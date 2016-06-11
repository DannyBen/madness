module Madness
  class Document
    include ServerHelper

    attr_reader :file, :dir, :path

    def initialize(path)
      @path = path
      
      base = path.empty? ? docroot : "#{docroot}/#{path}"

      if File.directory? base
        @file = "#{base}/README.md"
        @dir  = base
      elsif File.exist? "#{base}.md"
        @file = "#{base}.md"
        @dir  = File.dirname file
      else
        @file = ''
        @dir  = docroot
      end
    end

    def content
      @content ||= content!
    end

    def content!
      File.exist?(file) ? RDiscount.new(File.read file).to_html : ""
    end

  end
end

