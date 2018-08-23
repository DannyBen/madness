module Madness
  module HashRefinements
    refine Hash do
      def symbolize_keys
        transform_keys &:to_sym
      end
    end
  end
end