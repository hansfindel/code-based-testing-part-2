class SkynetIsDesyncWithUs < RuntimeError
    def initialize(message="Skynet is desyn Run awaaaay")
        @message = message
    end

    def get_message
        as_json["message"]
    end
end