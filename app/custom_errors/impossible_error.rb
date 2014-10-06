class ImpossibleError < RuntimeError
    def initialize(message="Impossible battle outcome")
        @message = message
    end

    def get_message
        as_json["message"]
    end
end