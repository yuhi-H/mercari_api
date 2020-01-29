class ApplicationController < ActionController::API
    rescue_from ActionController::BadRequest, with: :error400

    def authorize!
        return if current_user
        render json: { messages: ['そのtokenおかしいお'] }, status: :unauthorized
    end

    def current_user
        User.where(token: bearer_token).first
    end

    private
    def bearer_token
        @bearer_token ||= begin
        pattern = /^Bearer /
        header = request.headers['Authorization']
        header.gsub(pattern, '') if header&.match(pattern)
        end
    end

    def error400(err)
        render status: :bad_request, json: {
            error: {
                messages: [err.message],
                status: 400
            }
        }
    end
end
