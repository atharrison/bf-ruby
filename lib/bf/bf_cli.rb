require 'thor'

module BF
  class Cli < Thor

    namespace :bf

    desc "execute", "Execute a BF program"
    method_option :program
    def execute
      puts "received #{options}"
      Interpreter.new(options['program']).execute
    end
  end
end
