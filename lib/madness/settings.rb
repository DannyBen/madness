require 'singleton'

module Madness
  
  # Handle the configuration options
  # Each configuration option has three sources
  # 1. The default value
  # 2. The setting as provided in the ./.madness.yml
  # 3. Any override provided later (for example, by the CommandLine class)
  class Settings
    include Singleton

    attr_accessor \
      :auto_h1, 
      :auto_nav,
      :bind, 
      :highlighter, 
      :index, 
      :line_numbers, 
      :path, 
      :port, 
      :sidebar, 
      :theme,
      :toc

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
      self.port = '3000'
      self.bind = '0.0.0.0'
      self.path = '.'
      self.auto_h1 = true
      self.auto_nav = true
      self.sidebar = true
      self.highlighter = true
      self.line_numbers = true
      self.index = false
      self.theme = nil
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