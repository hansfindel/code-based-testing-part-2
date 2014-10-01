class Skynet
  #Its a class to communicate with our central

  #In a future it will let fetch new codenames returning a valid array with new codenames
  def self.get_central_updates
    "Pending..."
    return [CodeName.new,CodeName.new]
  end
  def self.update_database
    new_codenames=get_central_updates
    new_codenames do |cn|
      if CodeName.find_by_name(:cn.name).nil?
        CodeName.create(name: cn[:name],info_reference: cn[:info_reference],damage: cn[:damage])
      else
        raise SkynetIsdesynchronizedWithUs
      end
    end
  end
end