module Mokio
  module Sluglize
    extend ActiveSupport::Concern

    included do
      validates :slug, uniqueness: { case_sensitive: false }
      validates :slug, presence: true
      before_validation :create_slug
      before_validation :update_slug
    end

    private

    def create_slug
      if self.slug.blank?
        if self.respond_to?(:slug_by_value)
          tmp = self.slug_by_value
        else
          tmp = self.name
        end
        self.slug = tmp.nil? ? '' : tmp.parameterize
      else
        self.slug = self.slug.parameterize
      end
    end

    def update_slug
      self.slug = self.slug.parameterize
    end

  end
end
