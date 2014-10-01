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