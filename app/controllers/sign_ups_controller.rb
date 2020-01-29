class SignUpsController < ApplicationController
  def create# ユーザー登録
    user = User.create!(sign_up_user_params)
    serializer = SignUpSerializer.new(user)
    render json: serializer.as_json
  end

  def sign_up_user_params
    params.require(:sign_up_user_params).permit(
      :name,
      :bio,
      :email,
      :password,
      :password_confirmation
    )
  end

end
