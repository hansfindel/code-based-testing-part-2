# == Schema Information
#
# Table name: code_names
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  info_reference :string(255)
#  damage         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  tech           :integer          default(0)
#

class CodeName < ActiveRecord::Base

    @@instance = nil

    has_many :robots

    validates :tech, numericality: { greater_than_or_equal_to: 0 }
    validates :name, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
    validates :name, uniqueness: true#, message: "should happen once per year"

    validates :info_reference, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
    validates :info_reference, format: { with: /wiki/ }#, message: "It has to have a wiki reference"

    validates :damage, numericality: { greater_than: 0 }


    def save
        if @@instance.nil?
            code_name = CodeName.find_by name: self.name
            if code_name.nil?
                super
            else
                @@instance = code_name
                true
            end
        else
            true
        end
    end

    def save!
        if @@instance.nil?
            code_name = CodeName.find_by name: self.name
            if code_name.nil?
                super
            else
                @@instance = code_name
                true
            end
        else
            true
        end
    end


end
