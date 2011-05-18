module Publication
  extend ActiveSupport::Concern

  included do
    scope :published, where(:published => true)
    scope :published_unless, lambda { |condition| condition ? scoped : published }
    scope :unpublished, where(:published => false)

    before_save :set_published_at, :if => :publishing?
    before_save :zero_published_at, :if => :unpublishing?
  end

  module InstanceMethods
    def set_published_at
      self.published_at = Time.now
    end

    def zero_published_at
      self.published_at = nil
    end

    def publishing?
      published_change == [false, true] or
      published_change == [nil, true]
    end

    def unpublishing?
      published_change == [true, false]
    end
  end
end
