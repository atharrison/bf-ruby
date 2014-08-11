module BF
  class Interpreter

    DATA_SIZE = 30_000

    attr_reader :program, :input_tokens

    def initialize(program)
      @program = Program.new(instructions: load_program(program))
      @input_tokens = []
    end

    def execute
      puts "Executing program:\n #{program.instructions}\n\n"
      run_safe
      puts "Done"
    end

    def run_safe
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
    end

    #def command
    #  program[@cmd_ptr]
    #end
    #
    #def open_to_close(open_paren_ptr)
    #  @open_to_close_hash[open_paren_ptr] ||= locate_matching_close
    #end
    #
    #def locate_matching_close
    #  open_ptr = @cmd_ptr
    #  curr_ptr = @cmd_ptr
    #  depth = 1
    #  loop do
    #    curr_ptr += 1
    #    command = program[curr_ptr]
    #    raise "Off the end" if curr_ptr > program.length
    #    if command == '['
    #      depth += 1
    #    elsif command == ']'
    #      depth -= 1
    #    else
    #      #nothing
    #    end
    #
    #    if command == ']' && depth == 0
    #      @close_to_open_hash[curr_ptr] = open_ptr
    #      @open_to_close_hash[open_ptr] = curr_ptr
    #      break
    #    end
    #  end
    #  curr_ptr
    #end
    #
    #def close_to_open(close_paren_ptr)
    #  @close_to_open_hash[close_paren_ptr]
    #end
    #
    #def terminated?
    #  @cmd_ptr >= program.length
    #end

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
