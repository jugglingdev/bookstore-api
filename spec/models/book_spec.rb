require 'rails_helper'

RSpec.describe Book, type: :model do

  context 'Validations tests' do
    it 'is not valid without a title' do
      book = build(:book, title: nil);
      expect(book).not_to be_valid
    end

    it 'is not longer than 255 characters' do
      book = build(:book, title: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false))
      expect(book).not_to be_valid
    end
  end

  context 'Associations test' do
    it 'belongs to an author' do
      book = build(:book)
      expect(book.author).to be_present
    end
  end

end