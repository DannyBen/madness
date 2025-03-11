require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

module Madness
  # Renderer with syntax highlighting support
  class CustomRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def block_code(code, language)
      if language == 'mermaid'
        "<pre class='mermaid'>#{code}</pre>"
      else
        super
      end
    end
  end
end
