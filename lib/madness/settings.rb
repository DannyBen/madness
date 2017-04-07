module Madness
  
  # Handle teh configuration options
  # Each configuration option has three sources
  # 1. The default value
  # 2. The setting as provided in the ./.madness.yml
  # 3. Any override provided later (for example, by the CommandLine 
  #    class)
  class Settings
    include Singleton

    attr_accessor :port, :bind, :path, :autoh1, 
      :highlighter, :line_numbers, :index, :development

    def initialize
      reset
    end

    # Force reload of the config file, set defaults, and then read from 
    # file.
    def reset
      @config_file = nil
      set_defaults
      load_from_file if config_file
    end

    def file_exist?
      File.exist? filename
    end

    def filename
      '.madness.yml'
    end

    private

    def set_defaults
      self.port   = '3000'
      self.bind   = '0.0.0.0'
      self.path   = '.'
      self.autoh1 = true
      self.highlighter = true
      self.line_numbers = true
      self.index = false
      self.development = false
    end

    def load_from_file
      config_file.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def config_file
      @config_file ||= config_file!
    end

    def config_file!
      if file_exist?
        YAML.load_file filename 
      else
        {}
      end
    end

  end
end