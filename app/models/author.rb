class Author < ApplicationRecord
    # validations
    validates :first_name, presence: true
    validates :last_name, presence: true

    # associations
    has_many :books
end
