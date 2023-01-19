module Madness
  module Commands
    class Theme < Base
      summary 'Create files for theme customization'

      usage 'madness theme full [PATH]'
      usage 'madness theme css'
      usage 'madness config (-h|--help)'

      command 'full', 'Create a full theme customization directory in PATH [default: _theme]'
      command 'css', 'Create a folder with the CSS file for customization'

      def full_command
        raise InitError, "Directory #{theme_path} already exists" if Dir.exist? theme_path

        FileUtils.cp_r File.expand_path('../../../app', __dir__), theme_path
        say "!txtgrn!Created #{theme_path} theme folder"
      end

      def css_command
        file = 'css/main.css'
        raise InitError, "File #{file} already exists" if File.exist? file

        FileUtils.mkdir_p 'css'
        FileUtils.cp_r File.expand_path('../../../app/public/css/main.css', __dir__), 'css/main.css'
        say '!txtgrn!Created css/main.css'
      end

    private

      def theme_path
        args['PATH'] || '_theme'
      end
    end
  end
end
