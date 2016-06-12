module Madness
  class Navigation
    include ServerHelper

    attr_reader :links, :caption

    def initialize(dir)
      files = Dir["#{dir}/*.md"].map { |f| f.sub(/\.md$/, '') }
      files.reject! { |f| File.basename(f) == 'README' }

      dirs  = Dir["#{dir}/*"].select { |f| File.directory? f }

      @caption = File.basename(dir) unless dir == docroot

      @links = []

      dirs.sort.each do |item|
        @links.push link(item, :dir)
      end

      files.sort.each do |item|
        @links.push link(item, :file)
      end
    end

    private

    def link(item, type)
      OpenStruct.new({ 
        label: File.basename(item).tr('-', ' '), 
        href: URI.escape(item.sub(/^#{docroot}/, '')), 
        type: type 
      })
    end
  end
end