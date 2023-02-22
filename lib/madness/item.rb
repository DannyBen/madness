module Madness
  class Item
    include ServerHelper
    using StringRefinements

    attr_reader :path, :type

    def initialize(path, type)
      @path = path
      @type = type
    end

    def label
      @label ||= label!
    end

    def href
      @href ||= begin
        result = path_without_extension.sub(/^#{docroot}/, '').to_href
        "#{config.base_uri}#{result}"
      end
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
