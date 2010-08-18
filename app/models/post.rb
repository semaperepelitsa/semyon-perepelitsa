class Post < ActiveRecord::Base
  validates_presence_of :text
  
  scope :recent, order('created_at desc')
  scope :last_updated, order('updated_at desc')
  
  scope :published, where(:published => true)
  def self.published_unless(condition)
    condition ? scoped : published
  end
  scope :unpublished, where(:published => false)
  
  before_update :update_created_at, :if => proc {|p| p.published_change == [false, true]}
  
  def update_created_at
    self.created_at = self.updated_at
  end

  def to_param
    r = id.to_s
    r+= "-#{title.parameterize}" if title.present?
    r
  end
end
