module Madness
  module HashRefinements
    refine Hash do
      def symbolize_keys
        clone.symbolize_keys!
      end

      def symbolize_keys!
        keys.each { |key| self[(key.to_sym rescue key) || key] = delete key }
        self
      end
    end
  end
end
