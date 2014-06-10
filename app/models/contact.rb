# == Schema Information
#
# Table name: contents
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  intro        :text
#  content      :text
#  type         :string(255)
#  home_page    :boolean
#  tpl          :string(255)
#  contact      :boolean
#  active       :boolean          default(TRUE)
#  lang_id      :integer
#  gallery_type :string(255)
#  editable     :boolean          default(TRUE)
#  deletable    :boolean          default(TRUE)
#  display_from :date
#  display_to   :date
#  created_at   :datetime
#  updated_at   :datetime
#  meta_id      :integer
#  gmap_id      :integer
#

class Contact < Content
  has_many :recipients, dependent: :destroy
  has_one :contact_template, dependent: :destroy

  # delegate :tpl, to: :contact_template

  accepts_nested_attributes_for :recipients
  accepts_nested_attributes_for :contact_template

  def recipient_emails=(emails)
    self.recipient_ids = Recipient.ids_from_emails(emails)
  end

  def recipient_emails
    self.recipients.map(&:email).join(',')
  end
end
