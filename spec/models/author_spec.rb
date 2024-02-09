require 'rails_helper'

RSpec.describe Author, type: :model do

  context 'Validations tests' do
    it 'is not valid without a first name' do
      author = build(:author, first_name: nil);
      expect(author).not_to be_valid
    end

    it 'is not valid without a last name' do
      author = build(:author, last_name: nil)
      expect(author).not_to be_valid
    end
  end

  context 'destroy author and books dependent on it' do
    let(:author) {create(:author)}
    let(:author_id) {author.id}

    before do
      author.destroy
    end

    it 'deletes books' do
      books = Book.where(author_id: author_id)
      expect(books).to be_empty
    end
  end

end