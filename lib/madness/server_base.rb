
module Madness

  # The base class for the sinatra server.
  # Initialize what we can here, but since there are values that will
  # become known only later, the #prepare method is provided.
  class ServerBase < Sinatra::Application
    helpers ServerHelper

    Sass::Plugin.options[:template_location] = 'app/styles'
    Sass::Plugin.options[:css_location] = 'app/public/css'
    Slim::Engine.set_options pretty: true

    use Sass::Plugin::Rack

    set :root, File.expand_path('../../', __dir__)
    set :views, File.expand_path('../../app/views', __dir__)
    set :public_folder, File.expand_path('../../app/public', __dir__)

    # Since we cannot use any config values in the main body of the class,
    # since they will be updated later, we need to set anything that relys
    # on the config values just before running the server.
    # The CommandLine class and the test suite should both call
    # `Server.prepare` before calling Server.run!
    def self.prepare
      use Rack::TryStatic, :root => "#{config.path}/public/", :urls => %w[/]
      set :bind, config.bind
      set :port, config.port
    end

    def self.config
      Settings.instance
    end
  end

end
