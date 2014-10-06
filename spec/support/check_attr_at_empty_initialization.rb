module CheckAttrAtEmptyInitialization

  class Matcher
    def initialize(attribute)
      @attr = attribute
    end

    def matches?(instance_object)  # model
      instance_object.valid?
      !instance_object.errors.has_key?(@attr)
    end

    def failure_message
        "Should always have the #{@attr} attribute"
    end

  end

  def check_attr_at_empty_initialization(attribute)
    Matcher.new attribute
  end

end