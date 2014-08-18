module BF
  module Instruction
    class OutputCharacter

      SAFE_OUTPUT = true
      SAFE_CHARACTERS = [9, 10, 13, (32..126).to_a].flatten

      def call(program)
        #binding.pry
        to_output = program.data[program.data_ptr]

        if SAFE_OUTPUT
          return unless SAFE_CHARACTERS.include?(to_output)
        end

        output = to_output.chr
        print program.data[program.data_ptr].chr
        program.output << output
        program.cmd_ptr + 1
      end
    end
  end
end
