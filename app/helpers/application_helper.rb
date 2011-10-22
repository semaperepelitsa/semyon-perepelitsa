module ApplicationHelper
  def error_for(field, model)
    res = ''
    human_field = model.class.human_attribute_name(field)
    model.errors[field].each do |error|
      res += content_tag :div, "#{human_field} #{error}", :class => 'error'
    end
    raw(res)
  end

  def counter_tag
    render "shared/counter" if Rails.env.production? && guest?
  end
end
