module Madness
  class Navigation
    include ServerHelper

    attr_reader :links

    def initialize(dir)
      files = Dir["#{dir}/*.md"].map { |f| f.sub(/\.md$/, '') }
      files.reject! { |f| File.basename(f) == 'README' }

      dirs  = Dir["#{dir}/*"].select { |f| File.directory? f }

      @links = []
      dirs.sort.each do |item|
        @links.push link(item, 'd')
      end

      files.sort.each do |item|
        @links.push link(item, 'f')
      end
    end

    private

    def link(item, type)
      OpenStruct.new({ 
        label: File.basename(item).tr('-', ' '), 
        href: item.sub(/^#{docroot}/, ''), 
        type: type 
      })
    end
  end
end