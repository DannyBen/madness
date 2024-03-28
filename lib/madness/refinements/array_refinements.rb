require 'naturally'

module Madness
  module ArrayRefinements
    refine Array do
      def nat_sort(by: nil)
        Naturally.sort self, by: by
      end
    end
  end
end
