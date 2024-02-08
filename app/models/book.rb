class Book < ApplicationRecord
  # validations
  validates :title, presence: true, length: { maximum: 255 }

  # associations
  belongs_to :author
end
