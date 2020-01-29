class SignUpSerializer < ActiveModel::Serializer
  attributes :id,
              :name,
              :bio,
              :token,
              :email,
              :created_at,
              :updated_at
end
