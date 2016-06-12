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

    def title
      if file =~ /README.md/
        result = File.basename File.dirname(file)
      else
        result = File.basename(file,'.md')
      end
      result.tr '-', ' '
    end

    private

    def markdown_to_html(html)
      html = RDiscount.new(File.read file).to_html
      html = syntax_highlight(html) if config.highlighter
      html = prepend_h1(html) if config.autoh1
      html
    end

    def prepend_h1(html)
      unless html[0..3] == "<h1>"
        html = "<h1>#{title}</h1>\n#{html}" 
      end
      html
    end

    def syntax_highlight(html)
      line_numbers = config.line_numbers ? :table : nil
      opts = { css: :style, wrap: nil, line_numbers: line_numbers }
      html.gsub(/\<code class="(.+?)"\>(.+?)\<\/code\>/m) do
        lang, code = $1, $2
        code = CGI.unescapeHTML code
        CodeRay.scan(code, lang).html opts
      end
    end
  end
end

