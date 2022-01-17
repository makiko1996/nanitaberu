class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :posts, through: :tagmaps
# 管理者側のカスタマイズ設定で注目食材か表示食材のどちらの登録か判断するために使用するカラム
  attr_accessor :selected_food

# 入力されたタグ名が登録済みか探す
  def self.search_tag(name)
    Tag.find_by(tag_name: name)
  end

# 注目食材か表示食材かを判断してアップデートする
  def self.update_display_tag(searched_tag, selected_food)
    if selected_food === "display_food"
      searched_tag.update(display_food: true)
    else
      searched_tag.update(pickup_food: true)
    end
  end
  
# 注目食材か表示食材かを判断して項目から外す
  def self.withdrew_display_tag(selected_tag, selected_food)
    if selected_food == "display_food"
      selected_tag.update(display_food: false)
    else
      selected_tag.update(pickup_food: false)
    end
  end
  
end
