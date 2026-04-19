# require 'sinatra/reloader'
require 'sinatra/base'
require 'slim'
require 'madness/live_reload'
require 'madness/middleware/live_reload'

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
    set :static, false

    class << self
      include ServerHelper

      def prepare
        set :bind, config.bind
        set :port, config.port
        set :views, theme.views_path

        set_basic_auth if config.auth
        setup_live_reload if config.live_reload
      end

      def setup_live_reload
        use Madness::Middleware::LiveReload
        Madness::LiveReload.watch(File.expand_path(config.path, Dir.pwd))
        at_exit { Madness::LiveReload.stop }
      end

      def set_basic_auth
        use Rack::Auth::Basic, config.auth_zone do |username, password|
          config.auth.split(':') == [username, password]
        end
      end
    end
  end
end
