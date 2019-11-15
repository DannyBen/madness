require 'socket'
require 'os'

module Madness
  # Handles browser launching
  class Browser
    attr_reader :host, :port

    def initialize(host, port)
      @host, @port = host, port
    end

    # Returns a URL based on host, port nad MADNESS_FORCE_SSL.
    def server_url
      scheme = ENV['MADNESS_FORCE_SSL'] ? 'https' : 'http'
      url_host = ['0.0.0.0', '127.0.0.1'].include?(host) ? 'localhost' : host
      "#{scheme}://#{url_host}:#{port}"
    end

    # Returns true if the server is running. Will attempt to connect
    # multiple times. This is designed to assisn in running some code after
    # the server has launched.
    def server_running?(retries: 5, delay: 1)
      connected = false
      attempts = 0

      begin
        connected = Socket.tcp(host, port)
      rescue
        sleep delay
        retry if (attempts += 1) < retries
      ensure
        connected.close if connected
      end

      !!connected
    end

    # Open a web browser if the server is running. This is done in a
    # non-blocking manner, so it can be executed before starting the server.
    def open
      fork do
        if server_running?
          success = open!
          yield success ? nil : "Failed opening browser (#{open_command.join ' '})"
        else
          yield "Failed connecting to #{server_url}. Is the server running?"
        end
      end
    end

    # Run the appropriate command (based on OS) to open a browser.
    # Will display a helpful message on failure.
    def open!
      system *open_command, out: File::NULL, err: File::NULL
    end

    def open_command
      @open_command ||= [OS.open_file_command, server_url]
    end
  end
end
