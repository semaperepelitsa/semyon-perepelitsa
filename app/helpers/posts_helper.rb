module PostsHelper
  def compact_timestamp(timestamp)
    full = l(timestamp)
    short = l(timestamp.to_date, :format => :short)
    content_tag(:span, short, :title => full)
  end

end
