module Madness
  module StringRefinements
    refine String do
      def to_slug
        downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end

      # This is here so we can have one place that defines how to convert
      # a string (usually a filename without .md extension, or a folder name)
      # to a label.
      # It is used by different navigation elements in madness, and ucrrently
      # just removes any numbers followed by a dot at the beginning of the 
      # string, in order to allow "The Invisible Sorting Hand".
      def to_label
        gsub(/^\d+\.\s+/, '')
      end
    end
  end
end
