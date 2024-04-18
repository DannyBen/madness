require_relative 'pandoc'
require_relative 'redcarpet'

module Madness
  module Rendering
    class Handler
      HANDLERS = {
        redcarpet: Redcarpet,
        pandoc: Pandoc,
      }

      attr_reader :selector

      def initialize(selector) = @selector = selector
      def render(text) = handler.render(text)

    private

      def handler = @handler ||= handler_class.new
      def handler_class = @handler_class ||= HANDLERS[selector]
    end
  end
end