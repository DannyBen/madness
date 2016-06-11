module Madness
  class Settings
    include Singleton

    attr_accessor :port, :bind, :path, :autoh1, 
      :highlighter, :line_numbers

    def initialize
      reset
    end

    def reset
      self.port   = '3000'
      self.bind   = '0.0.0.0'
      self.path   = '.'
      self.autoh1 = true
      self.highlighter = true
      self.line_numbers = true
    end

  end
end