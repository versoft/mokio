# == Schema Information
#
# Table name: langs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  shortname  :string(255)
#  active     :boolean
#  menu_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
module Mokio
  class Lang < ActiveRecord::Base
    include Mokio::Concerns::Models::Lang
  end
end