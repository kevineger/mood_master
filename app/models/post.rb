class Post < ActiveRecord::Base
  include PgSearch
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :contents
  has_many :likes
  accepts_nested_attributes_for :contents, :allow_destroy => true

  mount_uploader :main_image, MainImageUploader

  pg_search_scope :tag_search, :associated_against => {
        :tags => :name
    }
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
    end
    self.save
  end
end
