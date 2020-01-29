class PurchaseSerializer < ActiveModel::Serializer
  attributes :id,
              :user_id,
              :item_id,
              :message,
              :status,
              :seller
    def seller
      user = User.where(id: object.owner_id).first
      UserSerializer.new(user)
    end
end
