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
      text.lines(chomp: true).each do |line|
        next unless line.start_with?('#', '```')
        next if inside_code_block? line

        matches = line.match(/^(?<level>\#{2,3})\s+(?<text>.+)/)
        next unless matches

        level = matches[:level].size - 2
        text = matches[:text]

        spacer = '  ' * level
        result.push "#{spacer}- [#{text}](##{text.to_slug})"
      end

      result.join "\n"
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
