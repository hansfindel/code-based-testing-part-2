class ContestSimulator

    def self.test(contender1, contender2)
        synchronous_test contender1, contender2
        get_result       contender1, contender2
    end
    
    def self.get_result(contender1, contender2)
        if contender1.alive? and contender2.alive?
            puts "Tie"
            raise ImpossibleError 
        elsif contender1.alive?
            puts "Contender 1"
            [contender1]
        elsif contender2.alive?
            puts "Contender 2"
            [contender2]
        else
            puts "Tragic Tie"
            []
        end 
    end
    # Método que recibe 2 conjuntos de robots (arrays) que se enfrentan unos a otros
    def self.team_challenge(team1, team2)
      robot1 =  team1.pop
      robot2 =  team2.pop
      while robot1 and robot2
        puts "team1: #{team1}"
        puts "team2: #{team2}"
        synchronous_test robot1, robot2
        result = get_result(robot1, robot2)[0]
        if result.equal? robot1 # gana robot1
          robot2 = team2.pop
          puts "robot1"
        elsif result.equal? robot2 # gana robot2
          robot1 = team1.pop
          puts robot1
          puts "robot2"
        else                      # empate (ambos mueren)
          robot1 =  team1.pop
          robot2 =  team2.pop
          puts "tie robot"
        end
      end
      if robot1
        "Team1"
      elsif robot2
        "team2"
      else
        "Tie"
      end
    end
    # test with:
    # begin
    #   ContestSimulator.get_result r1, r2
    # rescue Exception => e
    #   puts "Error: #{e} - #{e.get_message}"
    # end

    private
    def self.synchronous_test(contender1, contender2)
        while contender1.alive? and contender2.alive?
            attack(contender1, contender2)
            attack(contender2, contender1)
        end
    end

    def self.attack(contender1, contender2)
        from_1 = contender1.calculate_damage # contender2.remaining_health

        contender2.take_damage from_1
      puts "damage: #{from_1} to: #{contender2.health.current}"
    end
end