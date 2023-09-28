class BooksController < ApplicationController
   before_action :correct_user, only: [:update, :edit]
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end
    
  def create
    @book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id
    @book.save
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
    redirect_to user_path(@book.user)
    end
  end
  
  def update
    @book = Book.find(params[:id])
    @book_user_id = current_user.id
    @user = current_user
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)  
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroy."
    redirect_to '/books'
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
