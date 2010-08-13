module ApplicationHelper
  def delete_tag(path, name = 'Удалить')
    capture form_tag(path, :method => :delete) do
      submit_tag name, :class => 'delete'
    end
  end
  
  def markdownize text
    BlueCloth.new(text).to_html.html_safe
  end
  
  def title(str = nil)
    if str
      @page_title = str
    elsif @page_title.nil?
      @page_title = 'Поток мыслей'
    end
    @page_title
  end
end
