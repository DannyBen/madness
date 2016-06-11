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
      if File.exist?(file)
        html = RDiscount.new(File.read file).to_html
        html = prepend_h1(html, file) if config.autoh1
        html
      else
        ""
      end
    end

    def prepend_h1(html, filename)
      unless html[0..3] == "<h1>"
        html = "<h1>#{File.basename(filename,'.md')}</h1>\n#{html}" 
      end
      html
    end

  end
end

