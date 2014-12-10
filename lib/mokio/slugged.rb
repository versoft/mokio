module Mokio
  module Slugged
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