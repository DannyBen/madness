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
      @markdown ||= markdown!
    end

  protected

    def markdown!
      result = ["#{caption}\n"]
      meaningful_lines.each do |line|
        matches = line.match(/^(?<level>\#{2,3})\s+(?<text>.+)/)
        next unless matches

        result.push toc_item(matches[:text], matches[:level].size - 2)
      end

      result.join "\n"
    end

    def meaningful_lines
      text.lines(chomp: true).select { |line| meaningful_line? line }
    end

    def meaningful_line?(line)
      line.start_with?('#', '```') && !inside_code_block?(line)
    end

    def toc_item(text, level)
      spacer = '  ' * level
      "#{spacer}- [#{text}](##{text.to_slug})"
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
