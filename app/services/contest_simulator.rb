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
        #inicializamos las dos variable en false dado que ningun robot esta "congelado"
        contender1.set_freeze(false)
        contender2.set_freeze(false)
        contender1.set_nanities
        contender2.set_nanities
        while contender1.alive? and contender2.alive?
            #dlarrain
            #verifica que el robot no haya sufrido las conseciencias de freeze antes de que pueda atacar
            if contender1.freeze? == false
                attack?(contender1, contender2)
            else
                contender1.set_freeze(false)
            end
            if contender2.freeze? == false
                attack?(contender2, contender1)
            else
                contender2.set_freeze(false)
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


        if contender2.nanities == 0
            #Se activa  con probabilidad 1/3
            if rand(3) == 2
                contender2.increment_nanities #Esto ocurre al activarse por primera vez
            end
        end



        from_1 += contender2.nanities #en caso de q nanities este desactivado le sumaremos 0
        
        contender2.take_damage from_1
        
        if contender2.nanities > 0
            contender2.increment_nanities #esto ocurre cada vez que avanza un turno dado que ya esta activado nanities
        end

        #dlarrain
        #llamada del atacador para regenerarse una vez finalizado su ataque
        contender1.regenerate   

        #dlarrain
        #con probabilidad 1/3 el proximo robot no atacará
        if rand(3) == 1
            contender2.set_freeze(true)
        end
    end
end