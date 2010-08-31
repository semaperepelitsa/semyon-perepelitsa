class Post < ActiveRecord::Base
  validates_presence_of :text, :if => "published?"
  
  scope :recent, order('created_at desc')
  scope :last_updated, order('updated_at desc')
  
  scope :published, where(:published => true)
  def self.published_unless(condition)
    condition ? scoped : published
  end
  scope :unpublished, where(:published => false)
  
  before_update :update_timestamps, :if => :publish?
  
  def update_timestamps
    self.created_at = self.updated_at = Time.now
  end
  
  def publish?
    self.published_change == [false, true]
  end

  def to_param
    if permalink.present?
      [id, permalink].join('-')
    else
      id.to_s
    end
  end
  
  before_save :convert_title_to_permalink
  
  def convert_title_to_permalink
    self.permalink = (title.parameterize if title)
  end
end
