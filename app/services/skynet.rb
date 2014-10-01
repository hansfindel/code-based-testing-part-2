class Skynet
  #Its a class to communicate with our central
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

  #In a future it will let fetch new codenames
  def update_database
    "Pending..."
  end
end
