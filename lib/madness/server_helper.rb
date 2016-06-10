
module Madness
  module ServerHelper
    def config 
      @config ||= Config.instance
    end

    def docroot
      @docroot ||= File.expand_path(config.path, Dir.pwd)
    end
  end
end