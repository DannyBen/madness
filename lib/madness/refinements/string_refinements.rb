module Madness
  module StringRefinements
    refine String do
      def to_slug
        downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end
    end
  end
end
