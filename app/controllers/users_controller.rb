class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users =User.all
    @user = current_user
    @book = Book.new
  end

  def new
  	@users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end


   def update
   	@user = User.find(params[:id])
   	if @user.update(user_params)
       flash[:notice] = "successfully"
       redirect_to user_path
     else
      render :edit
    end
   end

   def edit
   	@user = User.find(params[:id])
    @book = Book.new
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
   end

   private
   def user_params
   	params.require(:user).permit(:name, :introduction, :profile_image)
   end
end
