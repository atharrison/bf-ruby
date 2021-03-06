require_relative 'chromosome'
require_relative 'population'

population = ::Genetic::Population.new
population.seed!

1.upto(NUM_GENERATIONS).each do |generation|

  offspring = Genetic::Population.new

  while offspring.count < population.count
    parent1 = population.select
    parent2 = population.select

    if rand <= CROSSOVER_RATE
      child1, child2 = parent1 & parent2
    else
      child1 = parent1
      child2 = parent2
    end

    child1.mutate!
    child2.mutate!

    if POPULATION_SIZE.even?
      offspring.chromosomes << child1 << child2
    else
      offspring.chromosomes << [child1, child2].sample
    end
  end

  puts "Generation #{generation} - Average: #{population.average_fitness.round(2)} - Max: #{population.max_fitness}"

  population = offspring
end

puts "Final population: " + population.inspect
