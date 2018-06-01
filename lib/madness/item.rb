module Madness
  class Item
    include ServerHelper
    using StringRefinements

    attr_reader :path, :type

    def initialize(path, type)
      @path, @type = path, type
    end

    def label
      @label ||= label!
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

    def label!
      File.basename(path_without_extension).to_label
    end

    def path_without_extension
      @path_without_extension ||= path.sub(/\.md$/, '')
    end
  end
end

