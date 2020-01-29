class PrivateChatsController < ApplicationController
    before_action :authorize!
    before_action :auth_buyer_and_seller

    def create
        chat = PrivateChat.new(private_chat_params)
        purchase = Purchase.find_by(id: params[:id])
        chat.item_id = purchase.item_id
        chat.user_id = current_user.id
        chat.save!
        serializer = PrivateChatSerializer.new(chat)
        render json: serializer.as_json
    end

    def index
        purchase = Purchase.find_by(id: params[:id])
        chat = PrivateChat.where(item_id: purchase.item_id)
        serializer = ActiveModel::Serializer::CollectionSerializer.new(
        chat,
        serializer: PrivateChatSerializer
        )
		render json: serializer.as_json
    end

    def auth_buyer_and_seller
        purchase = Purchase.where(id: params[:id]).first
        unless current_user.id == purchase.user_id || current_user.id == purchase.owner_id
            raise ActionController::BadRequest.new("購入者、売り手以外は参加できません！") and return
        end
    end

    def private_chat_params
        params.require(:private_chat_params).permit(
            :text
        )
    end
end
