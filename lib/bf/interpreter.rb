module BF
  class Interpreter

    DATA_SIZE = 30_000

    def initialize(program)
      @program = load_program(program)
      @data = Array.new(DATA_SIZE) { |idx| 0 }

      @cmd_ptr = 0
      @data_ptr = 0
      @open_to_close_hash = {}
      @close_to_open_hash = {}
      @input_tokens = []
    end

    def execute
      puts "Executing program:\n #{@program}\n\n"
      run_safe
      puts "Done"
    end

    def run_safe
      begin
        loop do
          #log_status
          command = @program[@cmd_ptr]

          case command
          when '>'
            @data_ptr += 1
            @cmd_ptr += 1
          when '<'
            @data_ptr -= 1
            @cmd_ptr += 1
          when '+'
            @data[@data_ptr] += 1
            @cmd_ptr += 1
          when '-'
            @data[@data_ptr] -= 1
            @cmd_ptr += 1
          when '.'
            print @data[@data_ptr].chr
            @cmd_ptr += 1
          when ','
            if @input_tokens.length == 0
              @input_tokens = STDIN.readline.scan(/./).push("\n")
            end
            @data[@data_ptr] = @input_tokens.shift
            @cmd_ptr += 1
          when '['
            open_to_close(@cmd_ptr)
            if @data[@data_ptr] == 0
              @cmd_ptr = open_to_close(@cmd_ptr) + 1
            else
              @cmd_ptr += 1
            end
          when ']'
            if @data[@data_ptr] != 0
              @cmd_ptr = close_to_open(@cmd_ptr) + 1
            else
              @cmd_ptr += 1
            end
          else
            #Ignore
          end

          break if terminated?
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

    def command
      @program[@cmd_ptr]
    end

    def open_to_close(open_paren_ptr)
      @open_to_close_hash[open_paren_ptr] ||= locate_matching_close
    end

    def locate_matching_close
      open_ptr = @cmd_ptr
      curr_ptr = @cmd_ptr
      depth = 1
      loop do
        curr_ptr += 1
        command = @program[curr_ptr]
        raise "Off the end" if curr_ptr > @program.length
        if command == '['
          depth += 1
        elsif command == ']'
          depth -= 1
        else
          #nothing
        end

        if command == ']' && depth == 0
          @close_to_open_hash[curr_ptr] = open_ptr
          @open_to_close_hash[open_ptr] = curr_ptr
          break
        end
      end
      curr_ptr
    end

    def close_to_open(close_paren_ptr)
      @close_to_open_hash[close_paren_ptr]
    end

    def terminated?
      @cmd_ptr >= @program.length
    end

    def load_program(program)
      if program.end_with?('bf')
        IO.binread("#{BF::ROOT}/#{program}").strip
      else
        program.strip
      end
    end

    def log_status
      puts "#{@cmd_ptr}\t#{@program[@cmd_ptr]}\t#{@data_ptr}\t#{@data[@data_ptr]}\t#{@data[0..30]}"
    end
  end
end
