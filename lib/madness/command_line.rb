module Madness
  class CommandLine
    include Singleton
    include Colsole

    def initialize
    end

    def execute(argv=[])
      evaluate_options(argv) unless argv.empty?
      show_status
      Server.run!
    end

    private

    def evaluate_options(argv)
      doc = File.read File.expand_path('docopt.txt', __dir__)
      begin
        args = Docopt::docopt(doc, argv: argv, version: VERSION)
        set_config args
      rescue Docopt::Exit => e
        puts e.message
      end
    end

    def set_config(args)
      config.path = args['PATH']
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
      @config ||= Config.instance
    end
  end
end
