module Madness
  # Provides different representations of the entire markdown directory.
  class Directory
    include ServerHelper

    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end
    
    # Returns a list of all the accepted items in the directory
    def list
      @list ||= (dirs + files)
    end

    private

    def files
      result = Dir["#{dir}/*.md"].map { |f| f.sub(/\.md$/, '') }
      result.reject! { |f| File.basename(f) == 'README' }
      result.sort.map { |path| item path, :file }
    end

    def dirs
      result = Dir["#{dir}/*"].select { |f| File.directory? f }
      result.reject! do |f| 
        basename = File.basename(f)
        basename =~ /^[a-z_\-0-9]+$/
      end
      result.sort.map { |path| item path, :dir }
    end

    def item(item, type)
      OpenStruct.new({ 
        label: File.basename(item), 
        href: URI.escape(item.sub(/^#{docroot}/, '')), 
        type: type 
      })
    end
  end
end
