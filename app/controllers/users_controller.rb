class UsersController < ApplicationController
    before_action :correct_user, only: [:update, :edit]
  def index
    @users= User.all
    @book = Book.new
    @user = current_user
  end
  
  
  def show
    @book= Book.new
    @books = Book.where(user_id:params[:id])
    @user = User.find(params[:id])
  end

  def edit
    user = User.find(params[:id])

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      @users = User.all
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user == @user
  end
end
