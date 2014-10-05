# module Person
#   def acts_as_person
#     include InstanceMethods
#     ############################ Class methods ################################
#     has_one :human, :as => :person, :autosave => true, :dependent => :destroy
#     alias_method_chain :human, :build
    
#     human_attributes = Human.content_columns.map(&:name) #<-- gives access to all columns of human
#     # define the attribute accessor method
#     def person_attr_accessor(*attribute_array)
#       attribute_array.each do |att|
#         define_method(att) do
#           human.send(att)
#         end
#         define_method("#{att}=") do |val|
#           human.send("#{att}=",val)
#         end
#       end
#     end
#     person_attr_accessor *human_attributes #<- delegating the attributes
#   end
 
#   module InstanceMethods
#     def human_with_build
#       human_without_build || build_human
#     end
#   end
# end