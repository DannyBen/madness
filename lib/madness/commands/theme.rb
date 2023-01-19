module Madness
  module Commands
    class Theme < Base
      summary 'Create files for theme customization'

      usage 'madness theme full [PATH]'
      usage 'madness config (-h|--help)'

      command 'full', 'Create a full theme customization directory in PATH [default: _theme]'

      def full_command
        raise InitError, "Directory #{path} already exists" if Dir.exist? path

        FileUtils.cp_r File.expand_path('../../../app', __dir__), path
        say "!txtgrn!Created #{path} theme folder"
      end

    private

      def path
        args['PATH'] || '_theme'
      end
    end
  end
end
