require 'singleton'
require 'extended_yaml'

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

    def dir_glob
      data[:expose_extensions] ? "*.{md,#{data[:expose_extensions].delete(' ')}}" : "*.md"
    end

  private

    def defaults
      {
        path: '.',
        port: 3000,
        bind: '0.0.0.0',
        sidebar: true,
        auto_h1: true,
        auto_nav: true,
        highlighter: true,
        line_numbers: true,
        copy_code: true,
        shortlinks: false,
        toc: nil,
        theme: nil,
        open: false,
        auth: false,
        auth_realm: 'Madness',
        expose_extensions: nil,
        exclude: [/^[a-z_\-0-9]+$/],
      }
    end

    def data
      @data ||= defaults.merge(file_data)
    end

    def file_data
      result = if file_exist?
        ExtendedYAML.load(filename)&.symbolize_keys
      else
        {}
      end

      result || {}
    end

  end
end
