module GeneticAlgorithm
  def random_chromosome
    Array.new(8) {rand(2)}
  end
  
  
  def fitness(chromosome)
    perfect = [0, 1, 0, 1, 0, 1, 0, 1]
    score = 0
    8.times do |i|
      if perfect[i] == chromosome[i]
        score += 1
      end
    end
    
    score/8.0 * 100
  end
  
  
  def population_fitness(population)
    population = population.map {|individual| fitness(individual)}
    population.inject{|sum, individual| sum + individual}/Float(population.length)
  end
  
  
  def crossover(a, b)
    a[0..3] + b[4..7]
  end
  
  
  def random_crossover(population)
    a = rand(population.length)
    b = rand(population.length)
    b = rand(population.length) while b == a
    crossover(population[a], population[b])
  end
  
  
  def mutate(chromosome)
    if rand(100) == 0
      n = rand(8)
      chromosome[n] = (chromosome[n] == 0) ? 1 : 0
    end
    
    chromosome
  end
  
  
  def selection(population)
    average_fitness = population_fitness(population)
    population.inject([]) do |elite, individual|
      fitness(individual) > average_fitness ? elite << individual : elite
    end
  end
  
  
  def next_generation(population)
    elite = selection(population)
    
    until elite.length == 1000
      elite << mutate(random_crossover(population))
    end
    
    elite
  end
  
  
  def generate_population(size=100)
    Array.new(size) {random_chromosome}
  end
  
  
  def evolve(generations=[])
    generations = [generate_population(1000)] if generations = []
    until population_fitness(generations.last) == 100
      generations << next_generation(generations.last)
    end
    generations
  end
  
  
end
