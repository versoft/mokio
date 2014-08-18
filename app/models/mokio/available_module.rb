# == Schema Information
#
# Table name: available_modules
#
#  id                 :integer          not null, primary key
#  created_at         :datetime
#  updated_at         :datetime
#  module_position_id :integer
#  static_module_id   :integer
#
module Mokio
  class AvailableModule < ActiveRecord::Base
    include Mokio::Concerns::Models::AvailableModule
  end
end
