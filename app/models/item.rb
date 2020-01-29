class Item < ApplicationRecord
    mount_uploader :image, ImageUploader

    belongs_to :user, optional: true
    has_one :purchase
    has_many :favorites
    has_many :users, through: :favorites
end
