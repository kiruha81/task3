class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
    @book = Book.new(book_params)
    if @book.user_id = current_user.id
      @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
    @books = Book.new
    @user = @books.user
  end

  def update
    @book = Book.find(params[:id])
    if @book.user_id = current_user.id
    else
      redirect_to book_path
    end
    @book.update(book_params)
    redirect_to book_path
  end

  def index
    @books = Book.all
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
