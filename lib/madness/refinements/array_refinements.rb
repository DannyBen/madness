module Madness
  module ArrayRefinements
    refine Array do
      def nat_sort
        Naturally.sort self
      end
    end
  end
end
