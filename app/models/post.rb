class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  belongs_to :taste
  attachment :image
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps
  has_many :favorites, dependent: :destroy

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

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag_name: old_tag)
    end

    new_tags.each do |new_tag|
      new_post_tag = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << new_post_tag
    end
    # tags.each do |tag|
    #   new_post_tag = Tag.find_or_create_by(tag_name: tag)
    #   self.tags << new_post_tag
    # end
  end

  def display_difficulty
    if self.difficulty = 3
      return "★★★(調理に30分以上)"
    elsif self.difficulty = 2
      return "★★☆(調理に15~30分)"
    else
      return "★☆☆(調理に15分未満)"
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
