class PrivateChatSerializer < ActiveModel::Serializer
  attributes :id,
              :text,
              :user_id,
              :item_id
end
