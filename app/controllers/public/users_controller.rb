class Public::UsersController < ApplicationController
  before_action :current_user_check, only:[:edit]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を変更しました"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  # URL直打ちした場合に他ユーザーの情報を変更できないようにする
  def current_user_check
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
    
  
end
