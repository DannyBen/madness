require 'pandoc-ruby'

module Madness
  module Rendering
    class Pandoc
      include ServerHelper

      def render(text)
        PandocRuby.new(text, [{ from: :markdown, to: :html }], *options).convert
      end

    private

      def options
        @options ||= config.highlighter ? [] : :no_highlight
      end
    end
  end
end
