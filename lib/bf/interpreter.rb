module BF
  class Interpreter

    attr_reader :program

    def initialize(program)
      @program = Program.new(instructions: load_program(program))
    end

    def execute
      puts "Executing program:\n #{program.instructions}\n\n"

      begin
        loop do
          program.execute_current_command
          break if program.terminated?
          #break if terminated?
        end
      rescue EOFError
        # Finished
      rescue => ex
        log_status
        puts ex.message
        puts ex.backtrace
        binding.pry
      end

      puts "Done"
    end

    def load_program(program)
      if program.end_with?('bf')
        IO.binread("#{BF::ROOT}/#{program}").strip
      else
        program.strip
      end
    end

    def log_status
      puts "#{program.cmd_ptr}\t#{program.current_command}\t#{program.data_ptr}\t#{program.current_data}\t#{program.data_range(0..30)}"
    end
  end
end
