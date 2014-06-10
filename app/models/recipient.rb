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

class Recipient < ActiveRecord::Base
  belongs_to :contact

  validates :email, :email => true

  def self.ids_from_emails(emails)
    emails.delete(' ').split(',').map {|m| Recipient.create(email: m).id }
  end
end
