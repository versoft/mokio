# == Schema Information
#
# Table name: contact_templates
#
#  id         :integer          not null, primary key
#  tpl        :text
#  created_at :datetime
#  updated_at :datetime
#  contact_id :integer
#
module Mokio
  class ContactTemplate < ActiveRecord::Base
    include Mokio::Concerns::Models::ContactTemplate
  end
end