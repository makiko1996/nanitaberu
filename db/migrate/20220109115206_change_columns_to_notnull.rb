class ChangeColumnsToNotnull < ActiveRecord::Migration[5.2]
  def up
    #postsテーブルのカラムにnotnull制約
    change_column_null :posts, :user_id, false
    change_column_null :posts, :cooking_name, false
    change_column_null :posts, :category_id, false
    change_column_null :posts, :image_id, false
    change_column_null :posts, :cooking_time, false
    change_column_null :posts, :difficulty, false
    change_column_null :posts, :taste_id, false
    
    #categoriesテーブルにnotnull制約
    change_column_null :categories, :category, false
    
    #favoritesテーブルにnotnull制約
    change_column_null :favorites, :post_id, false
    change_column_null :favorites, :user_id, false
    
    #tagmapsテーブルにnotnull制約
    change_column_null :tagmaps, :post_id, false
    change_column_null :tagmaps, :tag_id, false
    
    #tagsテーブルにnotnull制約
    change_column_null :tags, :tag_name, false
    
    #tastesテーブルにnotnull制約
    change_column_null :tastes, :taste, false
    
  end
  
  def down
    #postsテーブルのカラムにnotnull制約(down時)
    change_column_null :posts, :user_id, true
    change_column_null :posts, :cooking_name, true
    change_column_null :posts, :category_id, true
    change_column_null :posts, :image_id, true
    change_column_null :posts, :cooking_time, true
    change_column_null :posts, :difficulty, true
    change_column_null :posts, :taste_id, true
    
    #categoriesテーブルにnotnull制約(down時)
    change_column_null :categories, :category, true
    
    #favoritesテーブルにnotnull制約(down時)
    change_column_null :favorites, :post_id, true
    change_column_null :favorites, :user_id, true
    
    #tagmapsテーブルにnotnull制約(down時)
    change_column_null :tagmaps, :post_id, true
    change_column_null :tagmaps, :tag_id, true
    
    #tagsテーブルにnotnull制約(down時)
    change_column_null :tags, :tag_name, true
    
    #tastesテーブルにnotnull制約(down時)
    change_column_null :tastes, :taste, true
    
  end
end
