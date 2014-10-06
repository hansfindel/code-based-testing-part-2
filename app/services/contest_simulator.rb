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
            contender1.attack(contender2)
            contender2.attack(contender1)
        end
    end

end