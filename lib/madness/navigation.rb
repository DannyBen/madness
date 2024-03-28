module Madness
  # Handle the navigation links for a given directory
  class Navigation
    include ServerHelper
    using ArrayRefinements
    using StringRefinements

    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end

    def links
      @links ||= if config.sort_order == 'mixed'
        directory.list.nat_sort(by: :href)
      else
        directory.list
      end
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

    def config
      Settings.instance
    end
  end
end
