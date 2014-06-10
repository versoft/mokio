# == Schema Information
#
# Table name: recipients
#
#  id         :integer          not null, primary key
#  email      :string(255)      not null
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  contact_id :integer
#

require 'spec_helper'

describe Recipient do
  pending "add some examples to (or delete) #{__FILE__}"
end
