module Mokio
  module Slugged

    def localized_slug
      "/#{I18n.locale.to_s}#{slug}"
    end

    def slug
      "/#{slug_prefix}/#{id}/#{slug_candidate.parameterize}"
    end
    def print_slug
      "#{slug}/print"
    end
    protected
    def slug_prefix
      "content"
    end
    def slug_candidate
      title
    end
  end
end