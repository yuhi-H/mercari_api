class PublicChatsController < ApplicationController
  before_action :authorize!
  before_action :set_chat, only:[:update, :destroy, :show]

  def index# コメント一覧
    chats = PublicChat.where(item_id: params[:id])
    serializer = ActiveModel::Serializer::CollectionSerializer.new(
      chats,
      serializer: PublicChatSerializer
    )
    render json: serializer.as_json
  end

  def create# コメント投稿
    chat_content = PublicChat.new(chat_params)
    chat_content.user_id = current_user.id
    chat_content.item_id = params[:id]
    chat_content.save!
    serializer = PublicChatSerializer.new(chat_content)
    render json: serializer.as_json
  end

  def destroy# コメント削除
    @chat.destroy!
    render json: {'message': 'コメント消したぜべいべえ'}
  end

  def update# コメント編集
    @chat.update!(chat_params)
    serializer = PublicChatSerializer.new(@chat)
    render json: serializer.as_json
  end

  def chat_params
    params.require(:chat_params).permit(
      :text
    )
  end

  def set_chat
    @chat = PublicChat.where(id: params[:chat_id]).first
  end
end
