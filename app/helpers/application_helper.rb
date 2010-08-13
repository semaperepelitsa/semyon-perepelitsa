module ApplicationHelper
  def delete_tag(path, name = 'Удалить')
    capture form_tag(path, :method => :delete) do
      submit_tag name, :class => 'delete'
    end
  end
end
