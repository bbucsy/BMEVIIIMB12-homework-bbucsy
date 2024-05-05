class Photo < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :name, length: {minimum: 4, maximum: 40 }, presence: true
  validates :image, attached: true,  content_type: [:png, :jpg, :jpeg]


  def uploader
    user.email.split('@').first || user.email
  end
end
