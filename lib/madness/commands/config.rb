module Madness
  module Commands
    class Config < Base
      summary 'Manage the madness configuration file'

      usage 'madness config new'
      usage 'madness config show'
      usage 'madness config (-h|--help)'

      command 'new', 'Create a new .madness.yml configuration file'
      command 'show', 'Show all configuration options'

      def new_command
        raise InitError, "Configuration file #{config.filename} already exists" if File.exist? config.filename

        FileUtils.cp File.expand_path('../templates/madness.yml', __dir__), config.filename
        say "Created g`#{config.filename}` config file"
      end

      def show_command
        errors_found = false

        config.data.each do |key, value|
          value_color = config.defaults[key] == value ? 'n' : 'bb'
          if config.defaults.has_key?(key)
            key_color = 'g'
          else
            key_color = 'r'
            value_color = 'r'
            errors_found = true
          end

          say "#{key_color}`#{key.to_s.rjust 20}`:  #{value_color}`#{value || '~'}`"
        end

        say ''

        if config.file_exist?
          say "Values in bb`blue` loaded from g`#{config.filename}`"
        end

        return unless errors_found

        say 'Keys in r`red` are not recognized'
      end
    end
  end
end
