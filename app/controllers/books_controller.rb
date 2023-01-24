class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def show
    @bookid = Book.find(params[:id])
    @users = @bookid.user
    @user = current_user
    @books = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id = current_user.id
      redirect_to user_path(current_user.id)
    end
    @books = Book.new
    @user = @books.user
  end

  def update
    @book = Book.find(params[:id])
    if @book.user_id = current_user.id
      @book.update(book_params)
    else
      redirect_to book_path
    end
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
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
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
end
