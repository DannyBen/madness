require 'singleton'

module Madness
  
  # Handle the configuration options
  # Each configuration option has three sources
  # 1. The default value
  # 2. The setting as provided in the ./.madness.yml
  # 3. Any override provided later (for example, by the CommandLine class)
  class Settings
    include Singleton
    using HashRefinements

    def initialize
      reset
    end

    def method_missing(name, *args, &_blk)
      name_string = name.to_s
      
      if name_string.end_with? '='
        data[name_string.chop.to_sym] = args.first
      else
        data[name]
      end
    end

    # Force reload of the config file, set defaults, and then read from 
    # file.
    def reset
      @data = nil
    end

    def file_exist?
      File.exist? filename
    end

    def filename
      '.madness.yml'
    end

    private

    def defaults
      {
        port: 3000,
        bind: '0.0.0.0',
        path: '.',
        auto_h1: true,
        highlighter: true,
        line_numbers: true,
        index: false,
        theme: nil,
        open: false,

        auto_nav: true,
        sidebar: true
      }
    end

    def data
      @data ||= defaults.merge(file_data)
    end

    def file_data
      file_exist? ? YAML.load_file(filename).symbolize_keys : {}
    end

  end
end