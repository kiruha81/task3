class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/def_icon.png')
      image.attach(io: File.open(file_path), filename: 'def_icon.png', content_type: 'image/png')
    end
    image
  end
  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }
end
