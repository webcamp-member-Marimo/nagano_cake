class Item < ApplicationRecord
  has_one_attached :image
  has_many :genres, dependent: :destroy
end
