require 'require_all'

module BF

  ROOT = File.absolute_path("#{File.dirname(__FILE__)}/..")

end

require_all 'lib'
require 'pry'
require 'pry-nav'
