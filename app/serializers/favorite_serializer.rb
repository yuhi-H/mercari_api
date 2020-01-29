class FavoriteSerializer < ActiveModel::Serializer
  attributes :id,
              :user_id,
              :item
  def item
    item = Item.where(id: object.item_id).first
    ItemSerializer.new(item)
  end
end
