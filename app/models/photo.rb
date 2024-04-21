class Photo < ApplicationRecord
  has_one_attached :image


  validates :name, length: {minimum: 4, maximum: 40 }, presence: true
  validates :image, attached: true,  content_type: [:png, :jpg, :jpeg]

end
