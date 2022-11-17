require 'fileutils'
require 'singleton'
require 'colsole'
require 'docopt'

module Madness
  # Handle command line execution. Used by bin/madness.
  class CommandLine
    include Singleton
    include Colsole

    # Process ARGV by putting it through docopt
    def execute(argv = [])
      doc = File.read File.expand_path('docopt.txt', __dir__)

      begin
        args = Docopt.docopt(doc, argv: argv, version: VERSION)
        handle args
      rescue Docopt::Exit => e
        puts e.message
      end
    end

  private

    # Separate between the two main modes: Create something, or launch
    # the server.
    def handle(args)
      if args['create']
        create_config if args['config']
        create_theme(args['FOLDER']) if args['theme']
      else
        launch_server_with_options args
      end
    end

    # Execute some pre-server-launch operations if needed, execute the
    # server, and launch the browser if requested.
    def launch_server_with_options(args)
      set_config args
      generate_stuff
      open_browser if config.open
      launch_server unless args['--and-quit']
    end

    # Launch the server, but not before doing some checks and making sure
    # we ask it to "prepare". This will set the server options such as port
    # and static files folder.
    def launch_server
      unless File.directory? config.path
        $stderr.puts "Invalid path (#{config.path})"
        return
      end

      show_status
      Server.prepare
      Server.run!
    end

    # Get the arguments as provided by docopt, and set them to our own
    # config object.
    def set_config(args)
      config.path         = args['PATH'] if args['PATH']
      config.port         = args['--port'].to_i if args['--port']
      config.bind         = args['--bind'] if args['--bind']
      config.toc          = args['--toc']  if args['--toc']
      config.auth         = args['--auth'] if args['--auth']
      config.auth_realm   = args['--auth-realm'] if args['--auth-realm']

      config.auto_h1      = false   if args['--no-auto-h1']
      config.auto_nav     = false   if args['--no-auto-nav']
      config.sidebar      = false   if args['--no-sidebar']
      config.highlighter  = false   if args['--no-syntax']
      config.line_numbers = false   if args['--no-line-numbers']
      config.copy_code    = false   if args['--no-copy-code']
      config.shortlinks   = true    if args['--shortlinks']
      config.open         = true    if args['--open']

      config.theme = File.expand_path(args['--theme'], config.path) if args['--theme']
    end

    # Generate index and toc, if requested by the user.
    def generate_stuff
      build_toc if config.toc
    end

    # Create config
    def create_config
      if File.exist? config.filename
        say "!txtred!Abort: config file #{config.filename} already exists"
      else
        FileUtils.cp File.expand_path('templates/madness.yml', __dir__), config.filename
        say "!txtgrn!Created #{config.filename} config file"
      end
    end

    # Create theme
    def create_theme(path)
      if Dir.exist? path
        say "!txtred!Abort: folder #{path} already exists"
      else
        FileUtils.cp_r File.expand_path('../../app', __dir__), path
        say "!txtgrn!Created #{path} theme folder"
      end
    end

    # Say hello to everybody when the server starts, showing the known
    # config.
    def show_status
      say_status :start, 'the madness'
      say_status :env, Server.environment, :txtblu
      say_status :listen, "#{config.bind}:#{config.port}", :txtblu
      say_status :path, File.realpath(config.path), :txtblu
      say_status :use, config.filename if config.file_exist?
      say_status :theme, config.theme, :txtblu if config.theme

      say '-' * 60
    end

    # Generate the table of contents file
    def build_toc
      say_status :toc, "generating #{config.toc}"
      TableOfContents.new.build(config.toc)
    end

    def config
      @config ||= Settings.instance
    end

    # Open a web browser if the server is running. This is done in a
    # non-blocking manner, so it can be executed before starting the server.
    def open_browser
      browser = Browser.new config.bind, config.port
      browser.open do |error|
        say "!txtred!#{error}" if error
      end
    end
  end
end
