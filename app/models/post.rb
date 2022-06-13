class Post < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_one_attached :image
end
