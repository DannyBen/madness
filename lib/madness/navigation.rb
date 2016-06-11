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
        @links.push OpenStruct.new({ label: File.basename(item).tr('-', ' '), href: item.sub(/^#{docroot}/, ''), type: 'd' })
      end

      files.sort.each do |item|
        @links.push OpenStruct.new({ label: File.basename(item).tr('-', ' '), href: item.sub(/^#{docroot}/, ''), type: 'f' })
      end
    end
  end
end