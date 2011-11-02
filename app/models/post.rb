class Post < ActiveRecord::Base
  include Publication
  include FriendlyURL

  validates_presence_of :body, :if => :published?

  scope :recent, order('published_at desc')
  scope :last_updated, order('updated_at desc')

  def body
    BlueCloth.new(body_markdown).to_html if body_markdown
  end
end
