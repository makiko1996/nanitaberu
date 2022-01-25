class Public::PostsController < ApplicationController

  def index

  # 表示されたタグをクリックした場合の一覧表示
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.all
      
  # 料理名で検索した場合の一覧表示
    elsif params[:search_cooking_name]
      @posts = Post.search(params[:search_cooking_name])

  # 　食材名で検索した時の一覧表示
    elsif params[:search_food]
      @tag = Tag.search_tag(params[:search_food])
      @posts = @tag.posts.all

    # ヘッダーの「投稿一覧」をクリックした場合の表示（全投稿の表示）
    else
      @posts = Post.all
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    # 空欄でタグの文字列を区切る
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/)

    if @post.save
      @post.save_tag(tag_list)
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(" ")
  end

  def update
    @post = Post.find(params[:id])

    # 空欄でタグの文字列を区切る
    tag_list = params[:post][:tag_name].split(/[[:blank:]]+/)

    if @post.update(post_params)
      @post.save_tag(tag_list)
      flash[:notice] = "投稿の編集を保存しました"
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
  end


  private

    def post_params
      params.require(:post).permit(:user_id, :cooking_name, :category_id, :image, :cooking_time, :difficulty, :taste_id, :url)
    end
end
