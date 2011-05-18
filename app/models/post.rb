class Post < ActiveRecord::Base
  include Publication

  validates_presence_of :text, :if => "published?"

  scope :recent, order('published_at desc')
  scope :last_updated, order('updated_at desc')

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
