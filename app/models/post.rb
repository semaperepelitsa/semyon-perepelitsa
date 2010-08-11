class Post < ActiveRecord::Base
  validates_presence_of :text, :published
  
  scope :recent, order('created_at desc')
  scope :last_updated, order('updated_at desc')
  
  scope :published, where(:published => true)
  def self.published_unless(condition)
    condition ? scoped : published
  end
  scope :unpublished, where(:published => false)
end
