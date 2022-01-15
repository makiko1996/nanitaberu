class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "ユーザー情報を変更しました"
    redirect_to user_path(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
    
  
end
