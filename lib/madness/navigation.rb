module Madness
  # Handle the navigation links for a given directory
  class Navigation
    include ServerHelper
    using StringRefinements

    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end

    def links
      @links ||= directory.list
    end

    def caption
      @caption ||= (dir == docroot ? 'Index' : File.basename(dir).to_label)
    end

    def with_search?
      true
    end

  private

    def directory
      @directory ||= Directory.new(dir)
    end
  end
end
