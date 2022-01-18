class AddColumns < ActiveRecord::Migration[5.2]
  def change
    #postsテーブルのカラム追加
    add_column :posts, :user_id, :integer
    add_column :posts, :cooking_name, :string
    add_column :posts, :category_id, :integer
    add_column :posts, :image_id, :string
    add_column :posts, :cooking_time, :integer
    add_column :posts, :difficulty, :integer
    add_column :posts, :taste_id, :integer
    add_column :posts, :url, :string
    
    #categoriesテーブルのカラム追加
    add_column :categories, :category, :string
    
    #favoritesテーブルのカラム追加
    add_column :favorites, :post_id, :integer
    add_column :favorites, :user_id, :integer
    
    #tagmapsテーブルのカラム追加
    add_column :tagmaps, :post_id, :integer
    add_column :tagmaps, :tag_id, :integer
    
    #tagsテーブルのカラム追加
    add_column :tags, :tag_name, :string
    add_column :tags, :pickup_food, :boolean, default: false, null:false
    add_column :tags, :display_food, :boolean, default: false, null:false
    
    #tastesテーブルのカラム追加
    add_column :tastes, :taste, :string
    
  end
end
