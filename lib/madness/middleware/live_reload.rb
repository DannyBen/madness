module Madness
  module Middleware
    class LiveReload
      def initialize(app)
        @app = app
      end

      def call(env)
        if websocket_upgrade?(env)
          Madness::LiveReload.handle(env)
        else
          @app.call(env)
        end
      end

      private

      def websocket_upgrade?(env)
        Madness::LiveReload.websocket?(env) && env['PATH_INFO'] =~ %r{/_live_reload$}
      end
    end
  end
end
