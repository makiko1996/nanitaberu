class Public::HomesController < ApplicationController
    
    def top
      
    # 新着投稿の表示
      @new_posts = Post.order(create_at: :desc).limit(8)
      
    # 表示食材タグ名の表示
      @display_foods = Tag.where(display_food: true)
      
    # 注目食材（管理者側）で設定したタグに関連する投稿の表示
     #設定したタグの取得 
      @pickup_foods = Tag.where(pickup_food: true)
     #タグに関連づく投稿の取得  
      @pickup_foods.each do |pickup_food|
        @pickup_posts = pickup_food.posts.all
      end
      
    end
    
end