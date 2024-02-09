require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "GET /books" do
    
    let(:book) {create(:book)}

    before do
      book
      get "/books"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the books' do
      expect(response.body).to eq(Book.all.to_json)
    end
  end

  # show
  describe "GET /book/:id" do
    let(:book) {create(:book)}

    before do
      get "/books/#{book.id}"
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct book' do
      expect(response.body).to eq(book.to_json)
    end
  end

  # create
  describe 'POST /books' do
    context 'with valid params' do
      let(:author) {create(:author)}

      before do
        book_attributes = attributes_for(:book, author_id: author.id)
        post '/books', params: book_attributes
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end

      it 'creates a new book' do
        expect(Book.count).to eq(1)
      end
    end

    context 'with invalid params' do

      before do
        book_attributes = attributes_for(:book, author_id: nil)
        post '/books', params: book_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  # update
  describe "PUT /books/:id" do
    context 'with valid params' do
      let(:book) {create(:book)}

      before do
        book_attributes = attributes_for(:book, title: "Updated Title")
        put "/books/#{book.id}", params: book_attributes
      end

      it 'updates a book' do
        book.reload
        expect(book.title).to eq('Updated Title')
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      let(:book) {create(:book)}
      
      before do
        book_attributes = attributes_for(:book, title: nil)
        put "/books/#{book.id}", params: book_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  # destroy

  describe 'DELETE /book/:id' do
    let(:book) {create(:book)}

    before do
      delete "/books/#{book.id}"
    end

    it 'deletes a book' do
      expect(Book.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end
end
