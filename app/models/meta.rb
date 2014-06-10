# == Schema Information
#
# Table name: meta
#
#  id                 :integer          not null, primary key
#  g_title            :string(255)
#  g_desc             :string(255)
#  g_keywords         :string(255)
#  g_author           :string(255)
#  g_copyright        :string(255)
#  g_application_name :string(255)
#  f_title            :string(255)
#  f_type             :string(255)
#  f_image            :string(255)
#  f_url              :string(255)
#  f_desc             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Meta < ActiveRecord::Base
  has_many :menus
  has_many :contents

  accepts_nested_attributes_for :contents
  accepts_nested_attributes_for :menus

  def self.meta_attributes
    [:g_title, :g_desc, :g_keywords, :g_author, :g_copyright, :g_application_name, :f_title, :f_type, :f_image, :f_url, :f_desc, :id]
  end

  after_save :touch_many

  def touch_many
    menu = Menu.find_by_meta_id(self.id)
    content = Content.find_by_meta_id(self.id)
    
    menu.touch if menu
    content.touch(:etag) if content
  end
end
