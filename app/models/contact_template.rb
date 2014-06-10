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

class ContactTemplate < ActiveRecord::Base
  belongs_to :contact
  accepts_nested_attributes_for :contact


  def self.contact_template_attributes
    [ :tpl ]
  end
end
