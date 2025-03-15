require 'pandoc-ruby'

module Madness
  module Rendering
    class Pandoc
      include ServerHelper

      def render(text)
        text = process_mermaid_blocks text if config.mermaid
        PandocRuby.new(text, [{ from: :gfm, to: :html }], *options).convert
      end

    private

      def options
        @options ||= config.highlighter ? [] : :no_highlight
      end

      def process_mermaid_blocks(text)
        text.gsub(/```mermaid\s+(.+?)\s+```/m) do
          "<div class='mermaid'>#{$1.strip}</div>"
        end
      end
    end
  end
end
