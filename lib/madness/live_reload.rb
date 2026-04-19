require 'listen'
require 'faye/websocket'

module Madness
  class LiveReload
    class << self
      def watch(path)
        @clients = []
        @listener = Listen.to(path, &method(:on_change))
        @listener.start
      end

      def stop
        @listener&.stop
      end

      def add_client(ws)
        @clients << ws
        ws.on(:close) { @clients.delete(ws) }
      end

      def broadcast(files)
        @clients.each { |ws| ws.send(files.join(",")) }
      end

      def websocket?(env)
        Faye::WebSocket.websocket?(env)
      end

      def handle(env)
        ws = Faye::WebSocket.new(env)
        add_client(ws)
        ws.rack_response
      end

      private

      def on_change(modified, added, removed)
        files = (modified + added + removed).uniq
        files.each { |file| log_change(file) }
        broadcast(files)
      end

      def log_change(file)
        $stderr.puts "LiveReload: #{file}"
      end
    end
  end
end
