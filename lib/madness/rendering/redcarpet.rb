require 'redcarpet'

module Madness
  module Rendering
    class Redcarpet
      include ServerHelper

      def render(text)
        handler.render text
      end

    private

      def handler
        @handler ||= ::Redcarpet::Markdown.new renderer, options
      end

      def options
        @options ||= {
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

      def renderer
        handler_class.new with_toc_data: true
      end

      def handler_class
        config.highlighter ? HighlightRenderer : ::Redcarpet::Render::HTML
      end
    end
  end
end
