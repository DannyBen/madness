require 'commonmarker'

module Madness
  # Handle a pure markdown document.
  class Markdown
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
      @to_html ||= Commonmarker.to_html text,
        options: commonmarker_options,
        plugins: commonmarker_plugins
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

    def commonmarker_options
      {
        render:    { hardbreaks: false, unsafe_: true },
        extension: commonmarker_extensions,
      }
    end

    def commonmarker_plugins
      # https://docs.rs/syntect/5.0.0/syntect/highlighting/struct.ThemeSet.html#implementations
      # - base16-ocean.dark
      # - base16-eighties.dark
      # - base16-mocha.dark
      # - base16-ocean.light
      # - InspiredGitHub
      # - Solarized (dark)
      # - Solarized (light)

      if config.highlighter
        { syntax_highlighter: { theme: 'InspiredGitHub' } }
      else
        { syntax_highlighter: nil }
      end
    end

    def commonmarker_extensions
      {
        autolink:          true,
        description_lists: true,
        footnotes:         true,
        header_ids:        '',
        strikethrough:     true,
        # superscript:       true,  # conflicts with footnotes
        table:             true,
        tagfilter:         false,
        tasklist:          true,
      }
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
