module Madness
  # Represents a directory with markdown file sand subflders.
  class Directory
    include ServerHelper
    using ArrayRefinements
    using StringRefinements

    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end

    def list
      @list ||= (dirs + files)
    end

  private

    def files
      @files ||= begin
        result = Dir["#{dir}/#{config.dir_glob}"]
        result.reject! do |f|
          ['README.md', 'index.md'].include? File.basename(f)
        end
        result.reject! { |f| is_cover_page? f }
        result.nat_sort.map { |path| Item.new path, :file }
      end
    end

    def dirs
      @dirs ||= begin
        result = Dir["#{dir}/*"].select { |f| File.directory? f }
        result.reject! { |f| exclude? f }
        result.nat_sort.map { |path| Item.new path, :dir }
      end
    end

    def exclude?(path)
      return false unless config.exclude.is_a? Array

      basename = File.basename path
      config.exclude.each do |pattern|
        return true if basename&.match?(Regexp.new(pattern))
      end
      false
    end

    def is_cover_page?(path)
      dir_paths.include? path.remove(/\.md$/)
    end

    def dir_paths
      @dir_paths ||= dirs.map(&:path)
    end

    def config
      @config ||= Settings.instance
    end
  end
end
