module Madness
  module ServerHelper
    def config 
      @config ||= Settings.instance
    end

    def docroot
      @docroot ||= File.expand_path(config.path, Dir.pwd)
    end

    def log(obj)
      #:nocov:
      open('madness.log', 'a') { |f|
        f.puts obj.inspect
      }
      #:nocov:
    end
  end
end