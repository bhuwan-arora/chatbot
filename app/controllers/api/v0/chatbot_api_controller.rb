module Api
    module V0
        class ChatbotApiController < ApplicationController

            def wit_response
                q = params[:q]
                response = Api::V0::ChatbotApiModel.handle_response q
                render :json => response, :status => 200
            end
        end
    end
end
