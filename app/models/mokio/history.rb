module Mokio
  class History < ActiveRecord::Base
    include Mokio::Concerns::Models::History
  end
end
