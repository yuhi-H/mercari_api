class FavoritesController < ApplicationController
    before_action :authorize!
    before_action :set_fav, only: [:destroy]
    def create
        fav = Favorite.new
        fav.user_id = current_user.id
        fav.item_id = params[:id]
        fav.save!
        render json: {'message': '商品をお気に入りしたよ！'}
    end

    def destroy
        @fav.destroy!
        render json: {'message': 'お気に入り解除！！！'}
    end

    def index
        favorites = Favorite.where(user_id: current_user.id)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
        favorites,
        serializer: FavoriteSerializer
        )
		render json: serializer.as_json
    end

    def set_fav
        @fav = Favorite.where(id: params[:id]).first
    end
end
