module Madness
  module Commands
    class Theme < Base
      summary 'Create files for theme customization'

      usage 'madness theme full [PATH]'
      usage 'madness theme css'
      usage 'madness theme colors'
      usage 'madness config (-h|--help)'

      command 'full', 'Create a full theme customization directory in PATH [default: _theme]'
      command 'css', 'Create a folder with the entire CSS file for customization'
      command 'colors', 'Create a folder with CSS for overriding colors only'

      def full_command
        raise InitError, "Directory #{theme_path} already exists" if Dir.exist? theme_path

        FileUtils.cp_r File.expand_path('../../../app', __dir__), theme_path
        say "Created g`#{theme_path}` theme folder"
      end

      def css_command
        copy_file 'app/public/css/main.css', 'css/main.css'
      end

      def colors_command
        copy_file 'app/styles/_variables.scss', 'css/colors.css'
      end

    private

      def copy_file(source, target)
        raise InitError, "File #{target} already exists" if File.exist? target

        FileUtils.mkdir_p File.dirname(target)
        FileUtils.cp_r File.expand_path("../../../#{source}", __dir__), target
        say "Created g`#{target}`"
      end

      def theme_path
        args['PATH'] || '_theme'
      end
    end
  end
end
