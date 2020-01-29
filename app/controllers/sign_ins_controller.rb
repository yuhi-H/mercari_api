class SignInsController < ApplicationController
    def create# ログイン
        user = User.find_by(email: params[:sign_in_user_params][:email])
        if user.blank?
            raise ActiveRecord::RecordNotFound.new("そのemailないお") and return
        end
        if user.authenticate(params[:sign_in_user_params][:password])
            serializer = SignUpSerializer.new(user)
            render json: serializer.as_json
        else
            raise ActionController::BadRequest
        end
        
        def sign_in_user_params
            params.require(:sign_in_user_params).permit(
            :email,
            :password,
            :password_confirmation
        )
        end
    end
end
