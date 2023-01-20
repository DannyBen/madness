require 'mister_bin'

module Madness
  # The CLI class is used by the bashly binary and forwards incoming CLI
  # commands to the relevant Bashly::Commands class
  class CLI
    def self.runner
      runner = MisterBin::Runner.new version: Madness::VERSION,
        header: 'Markdown Madness - Instant Markdown Server',
        footer: "Help: m`madness COMMAND --help`\nDocs: bu`https://madness.dannyb.co`"

      # runner.route 'init',      to: Commands::Server
      runner.route 'server',    to: Commands::Server
      runner.route 'config',    to: Commands::Config
      # runner.route 'toc',       to: Commands::TOC
      runner.route 'theme',     to: Commands::Theme

      runner
    end
  end
end
