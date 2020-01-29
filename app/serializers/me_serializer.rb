class MeSerializer < ActiveModel::Serializer
    attributes :id,
                :name,
                :bio,
                :email,
                :created_at,
                :updated_at
end