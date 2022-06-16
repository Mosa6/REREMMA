class Post < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  #bookmarked_by?(user)を追加することで、既にブックマークしているかを検証
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
