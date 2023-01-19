require 'mister_bin'

module Madness
  module Commands
    class Base < MisterBin::Command
      def config
        @config ||= Settings.instance
      end
    end
  end
end
