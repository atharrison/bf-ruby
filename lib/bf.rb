require 'require_all'
require 'timeout'

module BF

  ROOT = File.absolute_path("#{File.dirname(__FILE__)}/..")

end

require_all 'lib'
require 'pry'
require 'pry-nav'
