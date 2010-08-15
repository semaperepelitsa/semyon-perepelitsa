module ApplicationHelper
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
