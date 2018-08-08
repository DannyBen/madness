module Madness

  # The Madness::Static middleware delegates requests to Rack::TryStatic middleware
  # trying to match a static file when the request doesn't finish with ".md"

  class Static

    def initialize(app, options)
      @app = app
      @static = ::Rack::TryStatic.new(app, options)
    end

    def call(env)
      orig_path = env['PATH_INFO']
      if orig_path.end_with? ".md"
        @app.call(env)
      else
        @static.call(env)
      end
    end
  end
end
