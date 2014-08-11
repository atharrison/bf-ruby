module BF
  module Instruction

    DECREMENT = Instruction::Decrement.new
    INCREMENT = Instruction::Increment.new
    INPUT_CHARACTER = Instruction::InputCharacter.new
    JUMP = Instruction::Jump.new
    JUMP_RETURN = Instruction::JumpReturn.new
    MOVE_LEFT = Instruction::MoveLeft.new
    MOVE_RIGHT = Instruction::MoveRight.new
    OUTPUT_CHARACTER = Instruction::OutputCharacter.new


    def self.act(command, program)
      return if instructions[command].nil?
      instructions[command].call(program)
    end

    def self.instructions
      {
          '>' => MOVE_RIGHT,
          '<' => MOVE_LEFT,
          '+' => INCREMENT,
          '-' => DECREMENT,
          '.' => OUTPUT_CHARACTER,
          ',' => INPUT_CHARACTER,
          '[' => JUMP,
          ']' => JUMP_RETURN,
      }
    end
  #
  #  def call(program)
  #    raise 'sub-classes implement details'
  #  end

  end
end
