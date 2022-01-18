class Public::FavoritesController < ApplicationController
  
  def index
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @posts = Post.find(favorites)
  end
  
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end
  
  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
  end
  
end
