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
module Mokio
  class Recipient < ActiveRecord::Base
    include Mokio::Concerns::Models::Recipient
  end
end