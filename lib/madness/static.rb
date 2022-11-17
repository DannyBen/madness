module Madness
  # The Madness::Static middleware delegates requests to
  # Rack::Static middleware unless the request URI ends with .md
  class Static
    def initialize(app, options)
      @app = app
      @static = Rack::Static.new app, options
    end

    def call(env)
      if env['PATH_INFO'].end_with? '.md'
        @app.call env
      else
        @static.call env
      end
    end
  end
end
