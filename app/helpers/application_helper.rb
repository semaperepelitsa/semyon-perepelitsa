module ApplicationHelper
  def delete_tag(path, name = 'Удалить')
    capture form_tag(path, :method => :delete) do
      submit_tag name, :class => 'delete'
    end
  end
  
  def markdownize text
    BlueCloth.new(text).to_html.html_safe
  end
  
end
