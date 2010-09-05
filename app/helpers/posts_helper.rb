module PostsHelper
  def compact_timestamp(timestamp)
    full = l(timestamp)
    short = l(timestamp.to_date, :format => :short)
    content_tag(:time, short, :title => full, :datetime => timestamp, :pubdate => :pubdate)
  end

end
