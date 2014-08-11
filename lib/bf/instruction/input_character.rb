module BF
  module Instruction
    class InputCharacter

      #attr_reader :input_tokens

      def initialize
        @input_tokens = []
      end

      def call(program)
        program.read_input
      #  if @input_tokens.length == 0
      #    @input_tokens = STDIN.readline.scan(/./).push("\n")
      #    #binding.pry
      #    #puts @input_tokens
      #  end
      #  #puts @input_tokens
      #  program.data[program.data_ptr] = @input_tokens.shift
        program.cmd_ptr + 1
      end
    end
  end
end
