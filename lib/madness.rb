require 'fileutils'
require 'singleton'
require 'yaml'

require 'slim'
require 'commonmarker'
require 'coderay'
require 'sass'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sass/plugin/rack'
require 'docopt'
require 'colsole'
require 'ferret'

require'byebug' if ENV['BYEBUG']

require 'madness/server_helper'

require 'madness/breadcrumbs'
require 'madness/command_line'
require 'madness/directory'
require 'madness/document'
require 'madness/navigation'
require 'madness/search'
require 'madness/server'
require 'madness/server_base'
require 'madness/settings'
require 'madness/table_of_contents'
require 'madness/try_static'
require 'madness/version'

