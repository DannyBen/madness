module Madness
  module Commands
    class Config < Base
      summary 'Manage the madness configuration file'

      usage 'bashly config new'
      usage 'bashly config (-h|--help)'

      command 'new', 'Create a new .madness.yml configuration file'

      def new_command
        raise InitError, "Configuration file #{config.filename} already exists" if File.exist? config.filename

        FileUtils.cp File.expand_path('../templates/madness.yml', __dir__), config.filename
        say "!txtgrn!Created #{config.filename} config file"
      end
    end
  end
end
