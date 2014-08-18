# == Schema Information
#
# Table name: module_positions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  tpl        :string(255)
#  created_at :datetime
#  updated_at :datetime
#
module Mokio
  class ModulePosition < ActiveRecord::Base
    include Mokio::Concerns::Models::ModulePosition
  end
end