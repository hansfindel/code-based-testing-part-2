class Optimization

  # Algoritmo genético sin crossover, y con selección por torneo de tamaño 2

  attr_accessor :max_value, :objects, :key
  attr_accessor :generations, :current_generation, :best

  def self.optimize(objects, key, max_value)
    o = Optimization.new(objects, key, max_value)
    o.run
    o.best[:objects]
  end

  def config
    {
      generations: 1000,
      population: 40,
      mutation: 0.1
    }
  end

  def initialize(objects, key, max_value)
    self.generations = 1
    self.current_generation = []
    self.objects = objects
    self.key = key
    self.max_value = max_value
    self.best = nil
  end

  def run
    if check_if_run
      create_initial_population
      repeat
      best
    else
      best
    end
  end

  def check_if_run
    # Algún elemento cabe justo?
    just_in = objects.clone.delete_if { |object| object[key] != max_value }
    if just_in.size > 0
      self.best = { objects: [just_in.first], fitness: 0 }
      return false
    end
    # Algún elemento es multiplo?
    multiple = objects.clone.delete_if { |object| max_value % object[key] }
    if multiple.size > 0
      self.best = { objects: [multiple.first], fitness: 0 }
      return false
    end
    true
  end

  def repeat
    while generations < config[:generations]
      #puts "gen##{generations} best: #{best[:fitness] if best.present?}"
      calculate_generation_fitness
      add_best_solution
      create_next_generation
      mutation
      break if best[:fitness] == 0
    end
  end

  def mutation
    current_generation.each do |solution|
      if Random.rand < config[:mutation]
        random_index = Random.rand(solution[:objects].size)
        solution[:objects][random_index] = objects.sample
      end
    end
  end

  def create_initial_population
    config[:population].times do
      solution = { objects: [] }
      while evaluate_solution_sum(solution) < max_value
        solution[:objects] << objects.sample
      end
      current_generation << solution
    end
  end

  def evaluate_solution_sum(solution)
    solution[:objects].map{ |object| object[key] }.reduce(:+) || 0
  end

  def set_fitness(solution)
    solution[:fitness] = fitness(solution)
  end

  def fitness(solution)
    value = evaluate_solution_sum(solution) - max_value
    return value if value >= 0
    self.class.penalized_fitness
  end

  def self.penalized_fitness
    100000000000000
  end

  def calculate_generation_fitness
    current_generation.each do |solution|
      set_fitness(solution)
    end
  end

  def add_best_solution
    if self.best.present?
      self.best = best_solution if self.best[:fitness] > best_solution[:fitness]
    else
      self.best = best_solution
    end
  end

  def best_solution
    current_generation.sort{ |x, y| x[:fitness] <=> y[:fitness] }.first
  end

  def create_next_generation

    next_generation = []

    while next_generation.size < config[:population]

      # Tomar dos pares de padres al azar, y mediante torneo elegir la siguiente generacion
      subset1 = random_parents
      subset2 = random_parents

      parent1 = tournament(subset1.first, subset2.first)
      parent2 = tournament(subset1.second, subset2.second)

      next_generation << parent1
      next_generation << parent2
    end

    self.current_generation = next_generation
    self.generations += 1
  end

  def random_parents
    [current_generation.sample, current_generation.sample]
  end

  def tournament(solution1, solution2)
    solution1[:fitness] < solution2[:fitness] ? solution1 : solution2
  end

end