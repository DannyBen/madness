require 'fileutils'
require 'singleton'
require 'yaml'

require 'coderay'
require 'colsole'
require 'commonmarker'
require 'docopt'
require 'ferret'
require 'rack/contrib/try_static'
require 'sass'
require 'sass/plugin/rack'
require 'sinatra/base'
require 'sinatra/reloader'
require 'slim'

require 'byebug' if ENV['BYEBUG']

require 'madness/refinements/string_refinements'

require 'madness/server_helper'

require 'madness/breadcrumbs'
require 'madness/command_line'
require 'madness/directory'
require 'madness/document'
require 'madness/item'
require 'madness/navigation'
require 'madness/search'
require 'madness/server'
require 'madness/server_base'
require 'madness/settings'
require 'madness/table_of_contents'
require 'madness/version'

