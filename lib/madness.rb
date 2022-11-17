if ENV['BYEBUG']
  require 'byebug'
  require 'lp'
end

require 'requires'

requires 'madness/refinements', 'madness/server_helper', 'madness'
