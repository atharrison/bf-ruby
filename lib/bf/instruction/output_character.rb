module BF
  module Instruction
    class OutputCharacter

      def call(program)
        binding.pry
        print program.data[program.data_ptr].chr
        program.cmd_ptr + 1
      end
    end
  end
end
