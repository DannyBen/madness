module Madness
  # Generate a markdown Table of Contents for a single document
  class InlineTableOfContents
    include ServerHelper
    using StringRefinements

    attr_reader :text

    def initialize(text)
      @text = text
    end

    def markdown
      @markdown ||= ([caption, ''] + items).join "\n"
    end

  protected

    def items
      @items ||= headers.map { |line| toc_item line }
    end

    def headers
      @headers ||= text.lines(chomp: true).select do |line|
        next if inside_code_block? line

        line.match(/^(?<level>\#{2,3})\s+(?<text>.+)/)
      end
    end

    def toc_item(line)
      matches = line.match(/^(?<level>\#{2,3})\s+(?<text>.+)/)
      return nil unless matches

      text = matches[:text]
      level = matches[:level].size - 2

      spacer = '  ' * level
      slug = text.to_slug

      # pandoc removes leading numbers and dots from header slugs, we do the same
      slug = slug.remove(/^[\d\-]+/) if config.renderer == 'pandoc'
      "#{spacer}- [#{text}](##{slug})"
    end

    def caption
      @caption ||= config.auto_toc.is_a?(String) ? config.auto_toc : '## Table of Contents'
    end

    def inside_code_block?(line)
      @marker ||= false

      if !@marker && line.start_with?('```')
        @marker = line[/^`{3,4}/]
      elsif @marker && line.start_with?(@marker)
        @marker = false
      end

      !!@marker
    end
  end
end
