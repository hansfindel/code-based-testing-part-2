module HealthManager
    extend ActiveSupport::Concern
    included do 
        puts "robot concer"
        # has_many ...
    end

    
    def alive?
        self.remaining_health > 0
    end

    def remaining_health
        self.health.current
    end

    def take_damage damage 
        # should not get lower than 0
        self.health.take_damage damage
    end

    #weapon

    def stable?
        self.alive?
    end

    def spent_bullet
        self.health.take_damage 1
        self.health.current
    end

    def play_dead
        @old_health = health.current if @old_health.blank? or health.current > 0
        health.current = 0
    end

end