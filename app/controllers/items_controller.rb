class ItemsController < ApplicationController
    before_action :authorize!
    before_action :set_item, only:[:update, :destroy, :show]

    def index# 商品一覧
        items = Item.all
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
            items,
            serializer: ItemSerializer
        )
		render json: serializer.as_json
    end

    def create# 商品出品
        item = Item.new(item_params)
        item.user_id = current_user.id
        item.save
        serializer = ItemSerializer.new(item)
        render json: serializer.as_json
    end

    def update# 商品編集
        @item.update!(item_params)
        serializer = ItemSerializer.new(@item)
        render json: serializer.as_json
    end

    def destroy# 商品削除
        @item.destroy!
        render json: {'message': '商品消したぜべいべえ'}
    end

    def show# 商品詳細
        serializer = ItemSerializer.new(@item)
        render json: serializer.as_json
    end

    def item_params
    params.require(:item_params).permit(
    :name,
    :price,
    :description,
    :image
    )
    end

    def set_item
        @item = Item.where(id: params[:id]).first
    end
end
