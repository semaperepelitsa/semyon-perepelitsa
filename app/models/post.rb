class Post < ActiveRecord::Base
  validates_presence_of :text
  
  scope :recent, order('created_at desc')
  
  scope :published, where(:published => true)
  def self.published_unless(condition)
    condition ? scoped : published
  end
  scope :unpublished, where(:published => false)
end
