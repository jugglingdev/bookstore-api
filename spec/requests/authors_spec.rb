require 'rails_helper'

RSpec.describe "Authors", type: :request do
  # index
  describe "GET /authors" do
    
    let(:author) {create(:author)}

    before do
      author
      get "/authors"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the authors' do
      expect(response.body).to eq(Author.all.to_json)
    end
  end

  # show
  describe "GET /post/:id" do
    let(:author) {create(:author)}

    before do
      get "/authors/#{author.id}"
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct author' do
      expect(response.body).to eq(author.to_json)
    end
  end

  # create
  describe 'POST /authors' do
    context 'with valid params' do

      before do
        author_attributes = attributes_for(:author)
        post '/authors', params: author_attributes
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end

      it 'creates a new author' do
        expect(Author.count).to eq(1)
      end
    end

    context 'with invalid params' do

      before do
        author_attributes = attributes_for(:author, first_name: nil)
        post '/authors', params: author_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  # update
  describe "PUT /authors/:id" do
    context 'with valid params' do
      let(:author) {create(:author)}

      before do
        author_attributes = { first_name: "John" }
        put "/authors/#{author.id}", params: author_attributes
      end

      it 'updates an author' do
        author.reload
        expect(author.first_name).to eq('John')
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      let(:author) {create(:author)}
      
      before do
        author_attributes = { first_name: nil }
        put "/authors/#{author.id}", params: author_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  # destroy

  describe 'DELETE /author/:id' do
    let(:author) {create(:author)}

    before do
      delete "/authors/#{author.id}"
    end

    it 'deletes an author' do
      expect(Author.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  describe "GET /authors/:id/books" do
    
    let(:author) {create(:author)}
    let(:books) {create_list(:book, 3, author: author)}

    before do
      books
      get "/authors/#{author.id}/books"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the books by the given author' do
      book_titles = books.map(&:title)
      expect(JSON.parse(response.body).map { |book| book["title"] }).to match_array(book_titles)
    end
  end
end
