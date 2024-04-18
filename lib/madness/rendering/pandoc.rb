require 'pandoc-ruby'

module Madness
  module Rendering
    class Pandoc
      def render(text)
        PandocRuby.new(text, from: :markdown, to: :html).convert
      end
    end
  end
end