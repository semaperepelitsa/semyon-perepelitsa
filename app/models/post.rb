class Post < ActiveRecord::Base
  validates_presence_of :text, :if => "published?"

  scope :recent, order('published_at desc')
  scope :last_updated, order('updated_at desc')

  scope :published, where(:published => true)
  def self.published_unless(condition)
    condition ? scoped : published
  end
  scope :unpublished, where(:published => false)

  before_save :set_published_at, :if => :publishing?
  before_save :zero_published_at, :if => :unpublishing?

  def set_published_at
    self.published_at = Time.now
  end

  def zero_published_at
    self.published_at = nil
  end

  def publishing?
    published_change == [false, true] or
    published_change == [nil, true]
  end

  def unpublishing?
    published_change == [true, false]
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
