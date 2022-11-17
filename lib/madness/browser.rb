require 'socket'
require 'os'

module Madness
  # Handles browser launching
  class Browser
    attr_reader :host, :port

    def initialize(host, port)
      @host = host
      @port = port
    end

    # Returns a URL based on host, port and MADNESS_FORCE_SSL.
    def server_url
      url_host = ['0.0.0.0', '127.0.0.1'].include?(host) ? 'localhost' : host
      "http://#{url_host}:#{port}"
    end

    # Returns true if the server is running. Will attempt to connect
    # multiple times. This is designed to assist in running some code after
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
    # It will yield an error message if it fails, or nil on success.
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

    # Runs the appropriate command (based on OS) to open a browser.
    def open!
      system(*open_command, err: File::NULL, in: File::NULL, out: File::NULL)
    end

    # Returns the appropriate command (based on OS) to open a browser.
    def open_command
      @open_command ||= [OS.open_file_command, server_url]
    end
  end
end
