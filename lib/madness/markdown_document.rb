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
      @to_html ||= Redcarpet::Markdown.new(redcarpet_renderer, redcarpet_options).render text
    end

  private

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

    def redcarpet_options
      @redcarpet_options ||= {
        no_intra_emphasis:   true,
        autolink:            true,
        tables:              true,
        fenced_code_blocks:  true,
        strikethrough:       true,
        space_after_headers: true,
        superscript:         true,
        underline:           true,
        highlight:           true,
        quote:               false,
        footnotes:           true,
      }
    end

    def redcarpet_renderer
      redcarpet_handler.new with_toc_data: true
    end

    def redcarpet_handler
      config.highlighter ? HighlightRenderer : Redcarpet::Render::HTML
    end

    def toc_caption
      @toc_caption ||= if config.auto_toc.is_a?(String)
        config.auto_toc
      else
        '## Table of Contents'
      end
    end

    def toc
      result = ["#{toc_caption}\n"]
      markdown.lines(chomp: true).each do |line|
        next unless line.start_with? '#'

        matches = line.match(/^(?<level>\#{2,3})\s+(?<text>.+)/)
        next unless matches

        level = matches[:level].size - 1
        text = matches[:text]

        spacer = '  ' * level
        result.push "#{spacer}- [#{text}](##{text.to_slug})"
      end

      result.join "\n"
    end
  end
end
