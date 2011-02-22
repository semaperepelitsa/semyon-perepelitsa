# encoding: UTF-8

module PostsHelper
  def compact_timestamp(timestamp)
    full = l(timestamp)
    short = l(timestamp.to_date, :format => :short)
    content_tag(:time, short, :title => full, :datetime => timestamp.xmlschema, :pubdate => :pubdate)
  end

  def timestamps_for(post)
    timestamps = if post.published?
      [post.published_at]
    else
      [post.created_at, post.updated_at]
    end
    timestamps.map{ |t| compact_timestamp(t) }.join(' … ').html_safe
  end
end
