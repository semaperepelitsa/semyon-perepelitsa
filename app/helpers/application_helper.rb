module ApplicationHelper
  def markdownize text
    BlueCloth.new(text).to_html.html_safe
  end
  
  def page_title
    title unless @page_title.present?
    @page_title
  end
  
  def title(str = nil, &block)
    str = t '.title', :default => :stream unless str.present?
    content = @page_title = str
    content << ' ' + with_output_buffer(&block) if block
    content_tag :h1, content.html_safe
  end
  
  def error_for(field, model)
    res = ''
    human_field = model.class.human_attribute_name(field)
    model.errors[field].each do |error|
      res += content_tag :div, "#{human_field} #{error}", :class => 'error'
    end
    raw(res)
  end
  
  def counter_tag
    if Rails.env.production? && !admin?
      html = <<EOC
<!-- Yandex.Metrika -->
<script src="//mc.yandex.ru/metrika/watch.js" type="text/javascript"></script>
<div style="display:none;"><script type="text/javascript">
try { var yaCounter1309037 = new Ya.Metrika(1309037); } catch(e){}
</script></div>
<noscript><div style="position:absolute"><img src="//mc.yandex.ru/watch/1309037" alt="" /></div></noscript>
<!-- /Yandex.Metrika -->
EOC
      html.html_safe
    end
  end
end
