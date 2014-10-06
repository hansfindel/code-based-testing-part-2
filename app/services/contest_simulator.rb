class ContestSimulator

    def self.test(robot1, robot2)
      if robot1.instance_of?(Robot) && robot2.instance_of?(Robot)
        synchronous_test robot1, robot2
        get_result       robot1, robot2
      elsif robot1.instance_of?(Array) && robot2.instance_of?(Array)
        while robot1.count>0 && robot2.count>0
          contender1=robot1[0]
          contender2=robot2[0]
          synchronous_test contender1, contender2
          if contender1.alive? and contender2.alive?
            raise ImpossibleError
          elsif contender1.alive?
            robot2.delete_at(0)
            puts "Contender 1 won"
            [contender1]
          elsif contender2.alive?
            robot1.delete_at(0)
            puts "Contender 2 won"
            [contender2]
          else
            robot1.delete_at(0)
            robot2.delete_at(0)
            puts "Tragic Tie"
            []
          end
        end
        if robot1.count>0
          puts "Team 1 won"
            robot1
        elsif robot2.count>0
          puts "Team 2 won"
            robot2
        end
      end

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

    private
    def self.synchronous_test(contender1, contender2)
        while contender1.alive? and contender2.alive?
            contender1.take_nanite_damage
            contender2.take_nanite_damage
            #Nanite damage could had killed them
            if !contender1.alive? or !contender2.alive?
              break
            end
            puts contender1
            puts contender2
            attack(contender1, contender2)
            attack(contender2, contender1)

            contender1.regenerate_after_attack
            contender2.regenerate_after_attack
        end
    end

    def self.attack(contender1, contender2)
        from_1 = contender1.calculate_damage # contender2.remaining_health
        contender2.take_damage from_1
    end
end