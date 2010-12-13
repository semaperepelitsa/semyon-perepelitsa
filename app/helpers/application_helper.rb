module ApplicationHelper
  def markdownize text
    BlueCloth.new(text).to_html.html_safe
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
      raw <<EOC
<!-- Yandex.Metrika -->
<script src="//mc.yandex.ru/metrika/watch.js" type="text/javascript"></script>
<div style="display:none;"><script type="text/javascript">
try { var yaCounter1309037 = new Ya.Metrika(1309037); } catch(e){}
</script></div>
<noscript><div style="position:absolute"><img src="//mc.yandex.ru/watch/1309037" alt="" /></div></noscript>
<!-- /Yandex.Metrika -->
EOC
    end
  end
  
  def ad
    <<END
<span style="background-color:#dd2850; padding:2px; font-size:80%; color:white;">* * *</span>
<span style="background-color:#000000; padding:2px; font-size:80%; color: white;">Публикации щедро не оплачены</span>
<span style="background-color:#dd2850; padding:2px; font-size:80%; color:white;">* * *</span>
END
  end
end
