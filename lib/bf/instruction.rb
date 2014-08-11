module BF
  module Instruction

    def self.act(command, program)
      return if instructions[command].nil?
      next_ptr = instructions[command].call(program)
      binding.pry if next_ptr.nil?
      program.cmd_ptr = instructions[command].call(program)
    end

    def self.instructions
      {
          '>' => Instruction::MoveRight.new,
          '<' => Instruction::MoveLeft.new,
          '+' => Instruction::Increment.new,
          '-' => Instruction::Decrement.new,
          '.' => Instruction::OutputCharacter.new,
          ',' => Instruction::InputCharacter.new,
          '[' => Instruction::Jump.new,
          ']' => Instruction::JumpReturn.new,
      }
    end
  #
  #  def call(program)
  #    raise 'sub-classes implement details'
  #  end

  end
end
