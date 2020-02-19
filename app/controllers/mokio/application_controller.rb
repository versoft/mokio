class Mokio::ApplicationController < ActionController::Base
  include Mokio::Concerns::Controllers::Application
  include Mokio::HeadersHelper

  before_action :set_no_cache_headers
end