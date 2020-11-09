require 'commonmarker'
require 'coderay'

module Madness

  # Handle a single markdown document.
  class Document
    include ServerHelper
    using StringRefinements

    attr_reader :base, :path, :type, :file, :dir, :title

    def initialize(path)
      @path = path
      @base = path.empty? ? docroot : "#{docroot}/#{path}"
      @base.chomp! '/'
      set_base_attributes
    end

    # Return the HTML for that document
    def content
      @content ||= content!
    end

    # Return the HTML for that document, force re-read.
    def content!
      [:empty, :missing].include?(type) ? "<h1>#{title}</h1>" : markdown_to_html
    end

  private

    # Identify file, dir and type.
    # :readme  - in case the path is a directory, and it contains index.md
    #            or README.md
    # :file    - in case the path is a *.md file
    # :empty   - in case it is a folder without README.md or index.md
    # :missing - in any other case, we don't know (will trigger 404)
    def set_base_attributes
      @dir  = docroot
      @type = :missing
      @file = ''
      @title = 'Index'

      if File.directory? base
        @title = File.basename(path).to_label unless path.empty?
        set_base_attributes_for_directory
      elsif md_file?
        @file = md_filename
        @title = File.basename(base).to_label
        @dir  = File.dirname file
        @type = :file
      end
    end

    def set_base_attributes_for_directory
      @dir  = base
      @type = :readme

      if File.exist? "#{base}/index.md"
        @file = "#{base}/index.md"
      elsif File.exist? "#{base}/README.md"
        @file = "#{base}/README.md"
      else
        @type = :empty
      end
    end

    def markdown
      @markdown ||= File.read file
    end

    def doc
      @doc ||= CommonMarker.render_doc markdown, :DEFAULT, [:table]
    end

    # Convert markdown to HTML, with some additional processing:
    # 1. Add anchors to headers
    # 2. Syntax highilghting
    # 3. Prepend H1 if needed
    def markdown_to_html
      replace_toc_marker
      add_anchor_ids
      html = doc.to_html :UNSAFE
      html = syntax_highlight(html) if config.highlighter
      html = prepend_h1(html) if config.auto_h1
      html
    end

    # Add anchors with IDs before all headers
    def add_anchor_ids
      doc.walk do |node|
        if node.type == :header
          anchor = CommonMarker::Node.new(:inline_html)

          next unless node.first_child.type == :text
          
          anchor_id = node.first_child.string_content.to_slug
          anchor.string_content = "<a id='#{anchor_id}'></a>"
          node.prepend_child anchor
        end
      end
    end

    # Replace <!-- TOC --> with a Table of Contents for the page
    def replace_toc_marker
      toc_marker = doc.find do |node|
        node.type == :html and node.string_content.include? "<!-- TOC -->"
      end

      return unless toc_marker

      toc = []
      doc.walk do |node|
        next unless node.type == :header
        level = node.header_level
        next unless level.between? 2, 3
        text = node.first_child.string_content
        spacer = "  " * (level - 1)
        toc << "#{spacer}- [#{text}](##{text.to_slug})"
      end

      toc = toc.join "\n"
      toc = CommonMarker.render_doc(toc).first_child
      toc_marker.insert_after toc
      toc_marker.insert_after CommonMarker.render_doc("## Table of Contents").first_child
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
      html.gsub(/\<code class="language-(.+?)"\>(.+?)\<\/code\>/m) do
        lang, code = $1, $2
        code = CGI.unescapeHTML code
        CodeRay.scan(code, lang).html opts
      end
    end

    def md_file?
      File.exist?("#{base}.md") || (File.exist?(base) && File.extname(base) == '.md')
    end

    def md_filename
      File.extname(base) == '.md' ? base : "#{base}.md"
    end
  end
end

