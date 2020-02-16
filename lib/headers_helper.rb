module HeadersHelper
  # helper made for preventing caching in admin panel
  def set_no_cache_headers
    response.headers["Expires"] = 'Mon, 01 Jan 2000 00:00:00 GMT'
    response.headers["Pragma"] = 'no-cache'
    response.headers["Cache-Control"] = 'no-cache, no-store'
  end
end