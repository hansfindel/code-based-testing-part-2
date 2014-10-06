module CheckHealthAtEmptyInitialization

  class Matcher
    def matches?(instance_object)  # model
      instance_object.health != nil
    end

    def failure_message
        "Should always have a Health instance attached"
    end

  end

  def check_health_at_empty_initialization
    Matcher.new 
  end

end