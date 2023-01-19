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
        config.data.each do |key, value|
          color = config.defaults[key] == value ? '' : '!bldblu!'
          say "!txtgrn!#{key.to_s.rjust 20}!txtrst!:  #{color}#{value || '~'}"
        end

        return unless config.file_exist?

        say "\nValues in !bldblu!blue!txtrst! loaded from !txtgrn!#{config.filename}"
      end
    end
  end
end
