class BookController < ApplicationController

    before_action :set_book, only: [:show, :update, :destroy]

    def index 
        books = Book.all
        render json: books, status: :ok
    end

    def show
        render json: @book, status: :ok
    end

    def create 
        book = Book.new(book_params)

        if book.save
            render json: book, status: :ok
        else
            render json: book.errors, status: :unprocessable_untity
        end
    end

    def update
        if @book.update(book_params)
            render json: @book, status: :ok
        else
            render json: @book.errors, status: :unprocessable_untity
        end
    end

    def destroy
        if @book.destroy
            render json: nil, status: :ok
        else
            render json: @book.errors, status: :unprocessable_untity
        end
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end

    def book_params
        params.permit(:title, :author_id)
    end

end
