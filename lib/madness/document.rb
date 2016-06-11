module Madness
  class Document
    include ServerHelper

    attr_reader :file, :dir, :path, :type

    def initialize(path)
      @path = path
      
      base = path.empty? ? docroot : "#{docroot}/#{path}"

      if File.directory? base
        @file = "#{base}/README.md"
        @dir  = base
        @type = :readme
      elsif File.exist? "#{base}.md"
        @file = "#{base}.md"
        @dir  = File.dirname file
        @type = :file
      else
        @file = ''
        @dir  = docroot
        @type = :empty
      end
    end

    def content
      @content ||= content!
    end

    def content!
      if File.exist?(file)
        html = markdown_to_html html
      else
        @type = :empty
        ""
      end
    end

    def markdown_to_html(html)
      html = RDiscount.new(File.read file).to_html
      html = syntax_highlight(html) if config.highlighter
      html = prepend_h1(html, file) if config.autoh1
      html
    end

    def prepend_h1(html, filename)
      unless html[0..3] == "<h1>"
        if filename =~ /README.md/
          h1 = File.basename File.dirname(filename)
        else
          h1 = File.basename(filename,'.md')
        end

        html = "<h1>#{h1}</h1>\n#{html}" 
      end
      html
    end

    def syntax_highlight(html)
      # Highlight only if language is provided
      line_numbers = config.line_numbers ? :table : nil
      html.gsub(/\<code( class="(.+?)")\>(.+?)\<\/code\>/m) do
        CodeRay.scan($3, $2).html css: :style, wrap: nil, line_numbers: line_numbers
      end

      # Highlight even without a language
      # html.gsub(/\<code( class="(.+?)")?\>(.+?)\<\/code\>/m) do
      #   lang = $2 || :text
      #   CodeRay.scan($3, lang).html css: :style, wrap: nil, line_numbers: :table
      # end
    end

  end
end

