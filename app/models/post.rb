class Post < ActiveRecord::Base
  include Publication
  include FriendlyURL

  validates_presence_of :text, :if => :published?

  scope :recent, order('published_at desc')
  scope :last_updated, order('updated_at desc')
end
