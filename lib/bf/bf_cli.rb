require 'thor'

module BF
  class Cli < Thor

    GENE_LENGTH = 64

    namespace :bf

    desc "execute", "Execute a BF program"
    method_option :program
    def execute
      puts "received #{options}"
      Interpreter.new(options['program']).execute
    end

    desc "create_hi", "Create a BF Program that says hi"
    method_option :iterations
    def create_hi
      iterations = options['iterations'].to_i || 10
      #binding.pry
      population = ::Genetic::Population.new(fitness_proc: Proc.new{ rand(2)})
      population.seed_with_genes!(
          Proc.new do
            (1..GENE_LENGTH).map{ Instruction.valid_alleles.sample }.join
          end
      )
      #binding.pry

      Genetic::Mutator.new.mutate(population, iterations, Proc.new{rand(2)})

      puts "Final population: " + population.inspect

    end

    #def bf_fitness_proc
    #  Proc.new do
    #    rand(2)
    #  end
    #end
  end
end
