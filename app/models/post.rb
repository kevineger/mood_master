class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  has_many :contents
  has_many :likes
  accepts_nested_attributes_for :contents, :allow_destroy => true

  def like(user)
    if !self.liked?(user)
  	  Likes.create(post: self, user: user).save
    end
  end
  def unlike(user)
    liked = Likes.where(user: user, post: self)
    if liked.exists?
      Likes.destroy(liked)
    end
  end
  def liked?(user)
    Likes.where(user: user, post: self).exists?
  end
  def add_tags_with_check(tags)
    tags.each do |to_tag|
      tag = Tag.where(name: to_tag)
      if tag.blank?
        tag = Tag.new(name: to_tag)
        tag.save
      end
      #   add to database
      self.tags << tag
      self.save
    end
  end
end
