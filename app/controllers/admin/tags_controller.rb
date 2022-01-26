class Admin::TagsController < ApplicationController

  def index
    @display_food = Tag.where(display_food: true)
    @pickup_food = Tag.where(pickup_food: true)
  end

  # トップページに表示する食品タグと注目食材の設定
  def update_tag
    searched_tag = Tag.search_tag(tag_params[:tag_name])

    if searched_tag
      Tag.update_display_tag(searched_tag, tag_params[:selected_food])
      redirect_to request.referer
    else
      redirect_to request.referer, notice: 'そのタグは未登録です'
    end
  end
  
  def withdrew_tag
    selected_tag = Tag.find(params[:id])
    
    if selected_tag
      Tag.withdrew_display_tag(selected_tag, tag_params[:selected_food])
      redirect_to admin_tags_path, notice: '更新しました'
    else
      redirect_to admin_tags_path
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name, :pickup_food, :display_food, :selected_food)
  end

end
