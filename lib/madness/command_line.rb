require 'socket'
require 'fileutils'
require 'singleton'
require 'colsole'
require 'docopt'
require 'os'

module Madness

  # Handle command line execution. Used by bin/madness.
  class CommandLine
    include Singleton
    include Colsole

    # Process ARGV by putting it through docopt
    def execute(argv=[])
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

    # Execute some pre-server-launch operations if needed, and execute
    # the server.
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
        STDERR.puts "Invalid path (#{config.path})" 
        return
      end

      show_status
      Server.prepare
      Server.run!
    end

    # Get the arguments as provided by docopt, and set them to our own
    # config object.
    def set_config(args)
      config.path  = args['PATH']   if args['PATH']
      config.port  = args['--port'].to_i if args['--port']
      config.bind  = args['--bind'] if args['--bind']
      config.toc   = args['--toc']  if args['--toc']
      config.auto_h1      = false   if args['--no-auto-h1']
      config.auto_nav     = false   if args['--no-auto-nav']
      config.sidebar      = false   if args['--no-sidebar']
      config.highlighter  = false   if args['--no-syntax']
      config.line_numbers = false   if args['--no-line-numbers']
      config.index        = true    if args['--index']
      config.open         = true    if args['--open']
      config.theme = File.expand_path(args['--theme'], config.path) if args['--theme']
    end

    # Generate index and toc, if requested by the user.
    def generate_stuff
      build_index if config.index
      build_toc   if config.toc
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

      say "-" * 60
    end

    # Build the search index
    def build_index
      search = Search.new
      say_status :index, "generating #{search.index_dir}"
      search.build_index
    end

    def build_toc
      say_status :toc, "generating #{config.toc}"
      TableOfContents.new.build(config.toc)
    end

    def config
      @config ||= Settings.instance
    end

    def server_url
      scheme = ENV['MADNESS_FORCE_SSL'] ? 'https' : 'http'
      host = config.bind == '0.0.0.0' ? 'localhost' : config.bind
      port = config.port
      
      "#{scheme}://#{host}:#{port}"
    end

    def server_running?(retries: 5, delay: 1)
      connected = false
      attempts = 0

      begin
        connected = Socket.tcp(config.bind, config.port)
      rescue
        sleep delay
        retry if (attempts += 1) < retries
      end

      connected
    end

    def open_browser
      fork { open_browser! if server_running? }
    end

    def open_browser!
      command = [OS.open_file_command, server_url]
      success = system *command, out: File::NULL, err: File::NULL

      if !success
        say "!txtylw!Failed launching browser (#{command.join ' '})" 
      end
    end
  end
end
