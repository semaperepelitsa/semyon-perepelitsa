module PostsHelper
  def compact_timestamp(timestamp)
    full = l(timestamp)
    short = l(timestamp.to_date, :format => :short)
    content_tag(:time, short, :title => full, :datetime => timestamp, :pubdate => :pubdate)
  end

  def timestamps_for(post)
    res = compact_timestamp(post.created_at)
    res << ' … '.html_safe + compact_timestamp(post.updated_at) unless post.published?
    res
  end
end
