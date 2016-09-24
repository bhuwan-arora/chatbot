module Api
    module V0
        class ChatbotApiModel

            def self.handle_response q
                response = ChatbotHelper.query q
                if response['type'] == "msg"
                    message = response["msg"]
                    json = {"message" => message}
                else
                    json = response
                end
                json
            end
        end
    end
end
