module Madness
  module Commands
    class Config < Base
      summary 'Manage the madness configuration file'

      usage 'bashly config new'
      usage 'bashly config show'
      usage 'bashly config (-h|--help)'

      command 'new', 'Create a new .madness.yml configuration file'
      command 'show', 'Show all configuration options'

      def new_command
        raise InitError, "Configuration file #{config.filename} already exists" if File.exist? config.filename

        FileUtils.cp File.expand_path('../templates/madness.yml', __dir__), config.filename
        say "!txtgrn!Created #{config.filename} config file"
      end

      def show_command
        errors_found = false

        config.data.each do |key, value|
          value_color = config.defaults[key] == value ? '' : '!bldblu!'
          if config.defaults.has_key?(key)
            key_color = '!txtgrn!'
          else
            key_color = '!txtred!'
            value_color = '!txtred!'
            errors_found = true
          end

          say "#{key_color}#{key.to_s.rjust 20}!txtrst!:  #{value_color}#{value || '~'}"
        end

        say ''

        if config.file_exist?
          say "Values in !bldblu!blue!txtrst! loaded from !txtgrn!#{config.filename}"
        end

        return unless errors_found
        
        say "Keys in !txtred!red!txtrst! are not recognized"
      end
    end
  end
end
