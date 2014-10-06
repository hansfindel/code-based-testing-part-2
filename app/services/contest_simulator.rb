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
    end
end