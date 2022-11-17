module Madness
  class Theme
    attr_reader :path

    def initialize(path = nil)
      @path = path
    end

    def views_path
      custom? ? "#{path}/views" : File.expand_path('../../app/views', __dir__)
    end

    def public_path
      custom? ? "#{path}/public" : File.expand_path('../../app/public', __dir__)
    end

    def custom?
      @custom ||= (path and Dir.exist? path)
    end
  end
end
