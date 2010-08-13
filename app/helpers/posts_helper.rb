module PostsHelper
  def compact_timestamp(timestamp)
    content_tag(:span, Russian::strftime(timestamp, '%e %B'), :title => Russian::strftime(timestamp))
  end

end
