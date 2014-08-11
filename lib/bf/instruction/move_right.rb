module BF
  module Instruction
    class MoveRight

      def call(program)
        program.data_ptr += 1
        program.cmd_ptr + 1
      end
    end
  end
end
