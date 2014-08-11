module BF
  module Instruction
    class JumpReturn

      def call(program)
        if program.data[program.data_ptr] != 0
          program.close_to_open(program.cmd_ptr) + 1
        else
          program.cmd_ptr + 1
        end
      end
    end
  end
end
