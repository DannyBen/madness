module Madness

  # Handle command line execution. Used by bin/madness.
  class CommandLine
    include Singleton
    include Colsole

    # Launch the server
    def execute(argv=[])
      launch_server_with_options argv
    end

    private

    # Execute the docopt engine to parse the options and then launch the
    # server.
    def launch_server_with_options(argv)
      doc = File.read File.expand_path('docopt.txt', __dir__)
      begin
        args = Docopt.docopt(doc, argv: argv, version: VERSION)
        set_config args
        generate_stuff
        launch_server unless args['--and-quit']

      rescue Docopt::Exit => e
        puts e.message
      end
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
      config.path = args['PATH']   if args['PATH']
      config.port = args['--port'] if args['--port']
      config.bind = args['--bind'] if args['--bind']
      config.toc  = args['--toc']  if args['--toc']
      config.autoh1       = false  if args['--no-auto-h1']
      config.highlighter  = false  if args['--no-syntax']
      config.line_numbers = false  if args['--no-line-numbers']
      config.index        = true   if args['--index']
    end

    # Generate index and toc, if requested by the user.
    def generate_stuff
      build_index if config.index
      build_toc   if config.toc
    end

    # Say hello to everybody when the server starts, showing the known 
    # config.
    def show_status
      say_status :start, 'the madness'
      say_status :env, Server.environment, :txtblu
      say_status :listen, "#{config.bind}:#{config.port}", :txtblu
      say_status :path, File.realpath(config.path), :txtblu
      say_status :use, config.filename if config.file_exist?
      say "-" * 40
    end

    # Build the search index
    def build_index
      say_status :start, :index
      Search.new.build_index
      say_status :done, :index
    end

    def build_toc
      say_status :start, "toc: #{config.toc}"
      TableOfContents.new.build(config.toc)
      say_status :done, :toc
    end

    def config
      @config ||= Settings.instance
    end
  end
end
