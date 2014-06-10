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

require 'spec_helper'

describe Lang do
  pending "add some examples to (or delete) #{__FILE__}"
end
