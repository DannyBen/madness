require 'addressable'

module Madness
  module StringRefinements
    refine String do
      def remove(regex)
        gsub regex, ''
      end

      def to_href
        Addressable::URI.escape self
      end

      def to_slug(renderer = nil)
        result = downcase.strip

        if renderer == 'pandoc'
          result.remove(/[^a-z0-9 ]/).gsub(' ', '-')
        else
          result.gsub(/[^[:alnum:]]/, '-').squeeze('-').remove(/(^-|-$)/)
        end
      end

      # This is here so we can have one place that defines how to convert
      # a string (usually a filename without .md extension, or a folder name)
      # to a label.
      # It is used by different navigation elements in madness, and ucrrently
      # just removes any numbers followed by a dot at the beginning of the
      # string, in order to allow "The Invisible Sorting Hand".
      def to_label
        remove(/^\d+\.\s+/).remove(/\.md$/)
      end
    end
  end
end
