module Madness
  module Commands
    class Server < Base
      summary 'Start the server'

      usage 'madness server [PATH] [options]'
      usage 'madness init (-h|--help)'

      param 'PATH', 'Path to the markdown directory (default: .)'

      option '-p --port NUMBER', 'Set server port number (default: 3000)'
      option '-b --bind ADDRESS', 'Set server listen address (default: 0.0.0.0)'
      option '-o --open', 'Open a web browser after launching'
      option '--auth USER:PASS', 'Enable basic authentication'
      option '--auth-zone NAME', 'The basic authentication realm (default: Restricted Documentation)'
      option '--theme FOLDER', 'Use a custom theme (either absolute or relative to the main documentation path)'

      example 'madness server'
      example 'madness server docs'
      example 'madness server docs -p 4567'
      example 'madness server docs --open'
      example 'madness server --auth user:secret --port 4000'
      example 'madness server --theme _mytheme'

      def run
        override_config args
        build_toc if config.toc
        open_browser if config.open
        launch_server
      end

    private

      def launch_server
        raise ConfigurationError, "Invalid path: #{config.path}" unless File.directory? config.path

        show_status
        Madness::Server.prepare
        Madness::Server.run!
      end

      def build_toc
        say "g`▌` generating #{config.toc}"
        Madness::TableOfContents.new.build(config.toc)
      end

      def open_browser
        browser = Browser.new config.bind, config.port
        browser.open do |error|
          say "r`#{error}`" if error
        end
      end

      def override_config(args)
        config.path       = args['PATH'] if args['PATH']
        config.port       = args['--port'].to_i if args['--port']
        config.bind       = args['--bind'] if args['--bind']
        config.auth       = args['--auth'] if args['--auth']
        config.auth_zone  = args['--auth-zone'] if args['--auth-zone']
        config.open       = true if args['--open']
        config.theme      = File.expand_path(args['--theme'], config.path) if args['--theme']
      end

      def show_status
        say 'g`▌` starting server'
        say "g`▌ env`    : #{Madness::Server.environment}"
        say "g`▌ listen` : #{config.bind}:#{config.port}"
        say "g`▌ path`   : #{File.realpath(config.path)}"
        say "g`▌ config` : #{config.filename}" if config.file_exist?
        say "g`▌ theme`  : #{config.theme}" if config.theme
        say ''
      end
    end
  end
end
