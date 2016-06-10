module Madness
  class Config
    include Singleton

    attr_accessor :port, :bind, :path

    def initialize
      self.port = 3000
      self.bind = '0.0.0.0'
      self.path = '.'
    end

  end
end