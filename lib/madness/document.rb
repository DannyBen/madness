module Madness

  # Handle a single markdown document.
  class Document
    include ServerHelper

    attr_reader :file, :dir, :path, :type

    # At initialization, we handle three file "types":
    # :readme - in case the path is a directory, then the only file we
    #           MAY show, is the README.md in it
    # :file   - in case the path is a *.md file
    # :empty  - in any other case, we don't know.
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

    # Return the HTML for that document
    def content
      @content ||= content!
    end

    # Return the HTML for that document, force re-read.
    def content!
      if File.exist?(file)
        markdown_to_html
      else
        @type = :empty
        ""
      end
    end

    # Return a reasonable HTML title for the file or directory
    def title
      if file =~ /README.md/
        result = File.basename File.dirname(file)
      else
        result = File.basename(file,'.md')
      end
      result.tr '-', ' '
    end

    private

    # Convert markdown to HTML, wit hsome additional processing:
    # 1. Syntax highilghting
    # 2. Prepend H1 if needed
    def markdown_to_html
      html = RDiscount.new(File.read file).to_html
      html = syntax_highlight(html) if config.highlighter
      html = prepend_h1(html) if config.autoh1
      html
    end

    # If the document does not start with an H1 tag, add it.
    def prepend_h1(html)
      unless html[0..3] == "<h1>"
        html = "<h1>#{title}</h1>\n#{html}"
      end
      html
    end

    # Apply syntax highlighting with CodeRay. This will parse for any
    # <code class='LANG'> sections in the HTML, pass it to CodeRay for
    # highlighting.
    # Since CodeRay adds another HTML escaping, on top of what RDiscount
    # does, we unescape it before passing it to CodeRay.
    #
    # Open StackOverflow question:
    # http://stackoverflow.com/questions/37771279/prevent-double-escaping-with-coderay-and-rdiscount
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

