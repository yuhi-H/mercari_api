class PublicChatSerializer < ActiveModel::Serializer
  attributes :id,
              :text,
              :item
  def item
    item = Item.where(id: object.item_id).first
    ItemSerializer.new(item)
  end
end
