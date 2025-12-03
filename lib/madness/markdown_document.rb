require 'redcarpet'

module Madness
  # Handle a pure markdown document.
  class MarkdownDocument
    include ServerHelper

    using StringRefinements

    attr_reader :markdown, :title

    def initialize(markdown, title: nil)
      @markdown = markdown
      @title = title || ''
    end

    def text
      @text ||= begin
        result = markdown
        result = parse_toc(result) if config.auto_toc
        result = parse_shortlinks(result) if config.shortlinks
        result = prepend_h1(result) if config.auto_h1
        result
      end
    end

    def to_html
      @to_html ||= renderer.render text
    end

  private

    def renderer
      @renderer ||= Rendering::Handler.new config.renderer
    end

    def parse_toc(input)
      input.gsub '<!-- TOC -->', toc
    end

    def parse_shortlinks(input)
      input.gsub(/\[\[([^\]]+)\]\]/) { "[#{$1}](#{$1.to_href})" }
    end

    def prepend_h1(input)
      return input if has_h1?(input)

      "# #{title}\n\n#{input}"
    end

    def has_h1?(input)
      lines = input.lines(chomp: true).reject(&:empty?)
      return false if lines.empty?

      lines[0].match(/^# \w+/) || (lines[1] && lines[0].match(/^\w+/) && lines[1].start_with?('='))
    end

    def toc
      @toc ||= toc_handler.markdown
    end

    def toc_handler
      @toc_handler ||= InlineTableOfContents.new markdown
    end
  end
end
