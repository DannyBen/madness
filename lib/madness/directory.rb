module Madness
  # Represents a directory with markdown file sand subflders.
  class Directory
    include ServerHelper
    using ArrayRefinements

    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end

    def list
      @list ||= (dirs + files)
    end

  private

    def files
      result = Dir["#{dir}/#{config.dir_glob}"]
      result.reject! do |f|
        ['README.md', 'index.md'].include? File.basename(f)
      end
      result.nat_sort.map { |path| Item.new path, :file }
    end

    def dirs
      result = Dir["#{dir}/*"].select { |f| File.directory? f }
      result.reject! { |f| exclude? f }
      result.nat_sort.map { |path| Item.new path, :dir }
    end

    def exclude?(path)
      return false unless config.exclude.is_a? Array

      basename = File.basename path
      config.exclude.each do |pattern|
        return true if basename =~ Regexp.new(pattern)
      end
      false
    end

    def config
      @config ||= Settings.instance
    end
  end
end
