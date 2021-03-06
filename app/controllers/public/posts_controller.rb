class Public::PostsController < ApplicationController
  before_action :current_user_check, only:[:edit]

  def index
    # 表示されたタグをクリックした場合の一覧表示
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.all

    # 料理名で検索した場合の一覧表示
    elsif params[:search_cooking_name]
      @posts = Post.search(params[:search_cooking_name])

    # 食材名で検索した時の一覧表示
    elsif params[:search_food]
      @tag = Tag.search_tag(params[:search_food])
      # タグ名が存在するかの確認
      if @tag.present?
        @posts = @tag.posts.all
      else
        @post = []
      end
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
    # Google Vision APIで画像からfoodが検出された場合は保存
    if params[:post][:image] != "{}"
      if Vision.get_image_data(params[:post][:image]).include?( "Food" || "Salad")
        if @post.save
          @post.save_tag(tag_list)
          redirect_to posts_path
        else
          render 'new'
        end
      # 画像からfoodが検出されない場合は保存できない
      else
        flash[:notice] = "食品ではない画像の可能性があるため投稿できません。"
        render 'new'
      end
    else
      flash[:notice] = "入力に不備があるため投稿できませんでした。"
      render 'new'
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
    if params[:post][:image] != "{}"
      # Google Vision APIで画像からfoodが検出された場合は保存
      if Vision.get_image_data(params[:post][:image]).include?( "Food" || "Salad")
        # 画像からfoodが検出された場合は
        if @post.update(post_params)
          @post.save_tag(tag_list)
          flash[:notice] = "投稿の編集を保存しました"
          redirect_to post_path(@post)
        else
          render 'edit'
        end
      # 画像からfoodが検出されない場合は保存できない
      else
        flash[:notice] = "食品ではない画像の可能性があるため投稿できません。"
        render 'edit'
      end
    else
      flash[:notice] = "入力に不備があるため投稿できませんでした。"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  # URL直打ちした場合に他ユーザーの投稿が変更できないようにする
  def current_user_check
    @post = Post.find(params[:id])
    if current_user != @post.user
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :cooking_name, :category_id, :image, :cooking_time, :difficulty, :taste_id, :url)
  end

end
