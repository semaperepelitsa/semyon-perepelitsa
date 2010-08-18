module ApplicationHelper
  def markdownize text
    BlueCloth.new(text).to_html.html_safe
  end
  
  def page_title
    if @page_title.present?
      @page_title
    else
      'Поток мыслей'
    end
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
