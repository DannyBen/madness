module Madness
  module HashRefinements
    refine Hash do
      def symbolize_keys
        keys.each do |key|
          self[(key.to_sym rescue key) || key] = delete key
        end

        self
      end
    end
  end
end