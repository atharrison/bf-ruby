module BF
  module Instruction
    class OutputCharacter

      def call(program)
        #binding.pry
        output = program.data[program.data_ptr].chr
        print program.data[program.data_ptr].chr
        program.output << output
        program.cmd_ptr + 1
      end
    end
  end
end
