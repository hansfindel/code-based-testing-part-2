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
        #dlarrain
        #inicializamos las dos variable en true dado que ningun robot esta "congelado"
        var1 = true
        var2 = true
        while contender1.alive? and contender2.alive?
            #dlarrain
            #verifica que el robot no haya sufrido las conseciencias de freeze antes de que pueda atacar
            if var1
                var2 = attack?(contender1, contender2)
            else
                var1 = true
            end
            if var2 
                var1 = attack?(contender2, contender1)
            else
                var2 = true
            end
        end
    end

    def self.attack?(contender1, contender2)
        #dlarrain
        #attacker check for remaining weapons or create a new one.
        if !contender1.remaining_weapons? 
            contender1.create_weapon
        end
        
        from_1 = contender1.calculate_damage # contender2.remaining_health

        contender2.take_damage from_1

        #dlarrain
        #llamada del atacador para regenerarse una vez finalizado su ataque
        contender1.regenerate   

        #dlarrain
        #verifica si el siguiente robot sufre consecuencias secundarias de freeze, 
        #lo cual ocurre con probabilidad 1/2
        contender2.freeze?
    end
end