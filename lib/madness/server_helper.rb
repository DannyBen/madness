module Madness
  # All the methods that we may need inside of any server route.
  # The module can also be included manually anywhere else.
  module ServerHelper
    def config
      @config ||= Settings.instance
    end

    def docroot
      @docroot ||= File.expand_path(config.path, Dir.pwd)
    end

    def theme
      @theme ||= Theme.new config.theme
    end

    def log(obj)
      # :nocov:
      open('madness.log', 'a') do |f|
        f.puts obj.inspect
      end
      # :nocov:
    end

    # Search for static file, first in the users docroot, then in the template
    # directory.
    def find_static_file(path)
      return nil if disallowed_static(path)

      candidates = [
        "#{config.path}/#{path}",
        "#{theme.public_path}/#{path}",
      ]

      candidates.each do |candidate|
        return candidate if File.file? candidate
      end

      nil
    end

    def disallowed_static(path)
      path.end_with?('.md') || path.empty? || File.basename(path).start_with?('.')
    end
  end
end
