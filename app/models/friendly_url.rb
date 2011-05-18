module FriendlyURL
  extend ActiveSupport::Concern

  included do
    before_save :convert_title_to_permalink
  end

  def convert_title_to_permalink
    self.permalink = (title.parameterize if title)
  end

  def to_param
    if permalink.present?
      [id, permalink].join('-')
    else
      id.to_s
    end
  end
end
