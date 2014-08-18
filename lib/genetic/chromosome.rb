POPULATION_SIZE = 24
NUM_BITS = 64
NUM_GENERATIONS = 1000
CROSSOVER_RATE = 0.7
#MUTATION_RATE = 0.001
MUTATION_RATE = 0.01

module Genetic
  class Chromosome

    attr_accessor :genes

    def initialize(args={})
      if args[:genes] == ""
        self.genes = (1..NUM_BITS).map{ rand(2) }.join
      else
        self.genes = args[:genes]
      end

      @fitness_proc = args[:fitness_proc] || Proc.new { genes.count("1") }
    end

    def to_s
      genes.to_s
    end

    def count
      genes.count
    end

    def fitness
      #@fitness_proc.call
      #genes.count("1")
      #puts "Calculating Fitness for #{genes}"
      output = execute_safely(genes) || ''
      fitness_value = [(output.length > 0), output.include?('h'), output.include?('i'), output == 'hi'].reduce(0) {|sum, val| sum += 1 if  val; sum}
      puts "Executed #{genes} -=- [#{output}] -=- #{fitness_value}" if rand > 0.95
      fitness_value
    end

    def execute_safely(genes)
      begin
        Timeout::timeout(3) do
        #  puts "Executing Safely #{genes}"
          output = ::BF::Interpreter.new(genes).execute
          #puts "output: #{output}"
        end
        #puts "output: #{output}"
      rescue => ex
        #binding.pry
        output = ''
      end
      #puts "fitness: #{output}"
      output
    end

    def mutate!
      mutated = ""
      0.upto(genes.length - 1).each do |i|
        allele = genes[i, 1]
        if rand <= MUTATION_RATE
          #mutated += (allele == "0") ? "1" : "0"
          mutated += BF::Instruction.valid_alleles.sample
        else
          mutated += allele
        end
      end

      self.genes = mutated
    end

    def &(other)
      locus = rand(genes.length) + 1

      child1 = genes[0, locus] + other.genes[locus, other.genes.length]
      child2 = other.genes[0, locus] + genes[locus, other.genes.length]

      return [
          Chromosome.new(genes: child1, fitness_proc: @fitness_proc),
          Chromosome.new(genes: child2, fitness_proc: @fitness_proc),
      ]
    end
  end
end
