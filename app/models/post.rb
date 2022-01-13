class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  belongs_to :taste
  attachment :image
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

  # save前に調理時間から難易度の判定をする
  before_save :level

  def level
    #調理時間30分以上の場合
    if cooking_time >= 30
      self.difficulty = 3

    #調理時間15分以上の場合
    elsif cooking_time >= 15
      self.difficulty = 2

    #調理時間15分以下の場合
    else
     self.difficulty = 1
    end
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end


end
