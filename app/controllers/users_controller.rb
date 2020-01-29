class UsersController < ApplicationController
    before_action :authorize!# トークンはこれ書けばいける
    before_action :set_user, only:[:update, :destroy]

    def update 
        @user.update!(user_params)
        serializer = MeSerializer.new(@user)
        render json: serializer.as_json
    end

    def destroy
        @user.destroy!
        render json: {'message': 'ユーザー削除完了！！！'}
    end

    def my_item# 自分が出品したもの一覧
        my_item = Item.where(user_id: current_user.id)
        render json: my_item.as_json
    end

    def my_bought
        bought = Purchase.where(user_id: current_user.id)
        render json: bought.as_json
    end

    def follows
        user = User.where(id: params[:id]).first
        followings = user.followings
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            followings,
            serializer: UserSerializer
        )
		render json: serializer.as_json
    end

    def followers
        user = User.where(id: params[:id]).first
        followers = user.followers
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            followers,
            serializer: UserSerializer
        )
		render json: serializer.as_json
    end


    def evaluate
        user = User.where(id: params[:id]).first
        evaluate = user.evaluate
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            evaluate,
            serializer: UserSerializer
        )
		render json: serializer.as_json
    end

    def evaluated
        user = User.where(id: params[:id]).first
        evaluated = user.evaluated
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            evaluated,
            serializer: UserSerializer
        )
		render json: serializer.as_json
    end

    def user_params
        params.require(:user_params).permit(
            :name,
            :bio
        )
    end

    def set_user
        @user = User.where(id: params[:id]).first
    end
end
