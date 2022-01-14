class Public::UsersController < ApplicationController
  
  def show
    @posts = current_user.posts
  end
  
  def edit
  end
  
  def update
  end
  
end
