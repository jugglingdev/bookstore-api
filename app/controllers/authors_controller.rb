class AuthorsController < ApplicationController

    before_action :set_author, only: [:show, :update, :destroy]

    def index 
        authors = Author.all
        render json: authors, status: :ok
    end

    def show
        render json: @author, status: :ok
    end

    def create 
        author = Author.new(author_params)

        if author.save
            render json: author, status: :ok
        else
            render json: author.errors, status: :unprocessable_entity
        end
    end

    def update
        if @author.update(author_params)
            render json: @author, status: :ok
        else
            render json: @author.errors, status: :unprocessable_entity
        end
    end

    def destroy
        if @author.destroy
            render json: nil, status: :ok
        else
            render json: @author.errors, status: :unprocessable_entity
        end
    end

    def books_index
        author = Author.find(params[:author_id])
        author_books = author.books
        render json: author_books, status: :ok
    end

    private

    def set_author
        @author = Author.find(params[:id])
    end

    def author_params
        params.permit(:first_name, :last_name)
    end
end
