module Madness
  # This class allows multiple public folders so that we can load our 
  # CSS from the gem-domain public folder, and other things from the 
  # user-domain public folder
  # 
  # TryStatic is borrowed from rack-contrib, since the gem is out of date
  # and does not work with Sinatra 2
  # 
  # It is used in `server_base.rb` like so:
  #
  #     use TryStatic, :root => "#{config.path}/public/", :urls => %w[/]
  # 
  # Ref:
  # - https://stackoverflow.com/questions/18966318/sinatra-multiple-public-directories
  # - https://github.com/rack/rack-contrib/blob/master/lib/rack/contrib/try_static.rb
  # - https://github.com/rack/rack-contrib/pull/129
  #
  class TryStatic
    def initialize(app, options)
      @app = app
      @try = ['', *options[:try]]
      # :nocov:
      @static = ::Rack::Static.new(
        lambda { |_| [404, {}, []] },
        options)
      # :nocov:
    end

    def call(env)
      orig_path = env['PATH_INFO']
      found = nil
      @try.each do |path|
        resp = @static.call(env.merge!({'PATH_INFO' => orig_path + path}))
        break if !(403..405).include?(resp[0]) && found = resp
      end
      found or @app.call(env.merge!('PATH_INFO' => orig_path))
    end
  end
end