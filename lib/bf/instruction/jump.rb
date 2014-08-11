module BF
  module Instruction
    class Jump

      def call(program)
        program.open_to_close(program.cmd_ptr)
        if program.data[program.data_ptr] == 0
          open_to_close(program.cmd_ptr) + 1
        else
          program.cmd_ptr + 1
        end
      end
    end
  end
end
