module Madness
  class CommandLine
    include Singleton
    include Colsole

    def initialize
    end

    def execute(argv=[])
      if argv.empty?
        launch_server
      else
        launch_server_with_options argv
      end
    end

    private

    def launch_server_with_options(argv)
      doc = File.read File.expand_path('docopt.txt', __dir__)
      begin
        args = Docopt::docopt(doc, argv: argv, version: VERSION)
        set_config args
        launch_server
      rescue Docopt::Exit => e
        puts e.message
      end
    end

    def launch_server
      unless File.directory? config.path
        puts "Invalid path (#{config.path})" 
        return
      end
      
      show_status
      Server.run!
    end

    def set_config(args)
      config.path = args['PATH'] if args['PATH']
      config.port = args['--port']
      config.bind = args['--bind']
    end

    def show_status
      say_status :start, 'the madness'
      say_status :listen, "#{config.bind}:#{config.port}", :txtblu
      say_status :path, config.path, :txtblu
      say "-" * 40
    end

    def config
      @config ||= Settings.instance
    end
  end
end
