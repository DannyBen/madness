require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

module Madness
  # Renderer with syntax highlighting support
  class HighlightRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end
end
