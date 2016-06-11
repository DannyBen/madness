module Madness
  class Settings
    include Singleton

    attr_accessor :port, :bind, :path, :autoh1

    def initialize
      reset
    end

    def reset
      self.port   = '3000'
      self.bind   = '0.0.0.0'
      self.path   = '.'
      self.autoh1 = true
    end

  end
end