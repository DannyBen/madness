module Madness
  class Item
    include ServerHelper

    attr_reader :path, :type

    def initialize(path, type)
      @path, @type = path, type
    end

    def label
      @label ||= File.basename(path_without_extension)
    end

    def href
      URI.escape(path_without_extension.sub(/^#{docroot}/, ''))
    end

    def dir?
      type == :dir
    end

    def file?
      type == :file
    end

    private

    def path_without_extension
      @path_without_extension ||= path.sub(/\.md$/, '')
    end
  end
end

