class ItemSerializer < ActiveModel::Serializer
  attributes :id,
              :name,
              :price,
              :description,
              :image,
              :user
  def user
    user = User.where(id: object.user_id).first
    UserSerializer.new(user)
  end
end

