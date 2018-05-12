module Madness
  # Represents a directory with markdown file sand subflders.
  class Directory
    include ServerHelper

    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end
    
    def list
      @list ||= (dirs + files)
    end

    private

    def files
      result = Dir["#{dir}/*.md"]
      result.reject! { |f| File.basename(f) == 'README.md' }
      result.sort.map { |path| Item.new path, :file }
    end

    def dirs
      result = Dir["#{dir}/*"].select { |f| File.directory? f }
      result.reject! do |f| 
        basename = File.basename(f)
        basename =~ /^[a-z_\-0-9]+$/
      end
      result.sort.map { |path| Item.new path, :dir }
    end
  end
end
