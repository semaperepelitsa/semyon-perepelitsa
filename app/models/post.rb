class Post < ActiveRecord::Base
  include Publication
  include FriendlyURL

  validates_presence_of :body, :if => :published?

  scope :recent, order('published_at desc')
  scope :last_updated, order('updated_at desc')

  def body
    markdown.render(body_markdown) if body_markdown
  end

private

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
  end
end
