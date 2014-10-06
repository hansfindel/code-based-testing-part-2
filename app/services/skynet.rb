class Skynet
  #Its a class to communicate with our central

  def self.update_database
    @new_codenames=get_central_updates
    @new_codenames.each do |cn|
      if CodeName.find_by_name(cn[:name]).nil?
        CodeName.create(name: cn[:name],info_reference: cn[:info_reference],damage: cn[:damage])
      else
        raise SkynetIsDesyncWithUs
      end
    end
  end

  private
  #In a future it will let fetch new codenames returning a valid array with new codenames
  def self.get_central_updates
    "To do it recieve the answer from the server and parse it to an array of codenames..."
    return [CodeName.new,CodeName.new]
  end
end