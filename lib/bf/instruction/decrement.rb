module BF
  module Instruction
    class Decrement

      def call(program)
        program.data[program.data_ptr] -= 1
        program.cmd_ptr + 1
      end
    end
  end
end
