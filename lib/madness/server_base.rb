# require 'sinatra/reloader'
require 'sinatra/base'
require 'slim'

module Madness

  # The base class for the sinatra server.
  # Initialize what we can here, but since there are values that will
  # become known only later, the #prepare method is provided.
  class ServerBase < Sinatra::Application
    helpers ServerHelper

    Slim::Engine.set_options pretty: true
    set :root, File.expand_path('../../', __dir__)
    set :environment, ENV['MADNESS_ENV'] || :production
    set :server, :puma

    # Since we cannot use any config values in the main body of the class,
    # since they will be updated later, we need to set anything that relys
    # on the config values just before running the server.
    # The CommandLine class and the test suite should both call
    # `Server.prepare` before calling Server.run!
    def self.prepare
      use Madness::Static, root: "#{config.path}/", urls: %w[/], cascade: true
      set :bind, config.bind
      set :port, config.port

      set_basic_auth if config.auth
      set_tempalate_locations
    end

    def self.set_tempalate_locations
      theme = Theme.new config.theme
      
      set :views, theme.views_path
      set :public_folder, theme.public_path
    end

    def self.set_basic_auth
      use Rack::Auth::Basic, config.auth_realm do |username, password|
        config.auth.split(':') == [username, password]
      end
    end

    def self.config
      Settings.instance
    end
  end

end
