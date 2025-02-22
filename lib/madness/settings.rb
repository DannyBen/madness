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

    def method_missing(name, *args, &)
      name_string = name.to_s

      if name_string.end_with? '='
        data[name_string.chop.to_sym] = args.first
      else
        data[name]
      end
    end

    def respond_to_missing?(*_args)
      true
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
      data[:expose_extensions] ? "*.{md,#{data[:expose_extensions].delete(' ')}}" : '*.md'
    end

    def data
      @data ||= defaults.merge(file_data)
    end

    def defaults
      {
        path:              '.',
        port:              3000,
        bind:              '0.0.0.0',
        renderer:          'redcarpet',
        base_uri:          nil,
        sort_order:        'dirs_first',
        sidebar:           true,
        auto_h1:           true,
        auto_nav:          true,
        auto_toc:          true,
        highlighter:       true,
        mermaid:           false,
        copy_code:         true,
        shortlinks:        false,
        source_link:       nil,
        source_link_label: 'Page Source',
        source_link_pos:   'bottom',
        toc:               nil,
        theme:             nil,
        open:              false,
        auth:              false,
        auth_zone:         'Restricted Documentation',
        expose_extensions: nil,
        exclude:           ['^[a-z_\-0-9]+$'],
      }
    end

  private

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
