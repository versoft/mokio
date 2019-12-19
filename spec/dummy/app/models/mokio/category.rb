class Mokio::Category < ActiveRecord::Base
  include Mokio::Concerns::Common::Structurable

  def self.structurable_custom_columns
    %w(name title content)
  end
end