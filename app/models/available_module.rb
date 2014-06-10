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

class AvailableModule < ActiveRecord::Base
  belongs_to :static_module
  belongs_to :module_position
  # acts_as_list :column => :seq, :scope => :module_position
  scope :not_selected_for_menu, -> (menu_id = -1) { 
      ids = SelectedModule.where(:menu_id => menu_id).pluck(:available_module_id)
      joins("join static_modules on available_modules.static_module_id = static_modules.id").
      where('available_modules.id not in (?) and always_displayed = 0', ids.empty? ? '-1' : ids)
  }
  # scope :selected_for_menu, -> (menu_id = -1) { 
  #     ids = SelectedModule.where(:menu_id => menu_id).pluck(:available_module_id)
  #     joins("join static_modules on available_modules.static_module_id = static_modules.id").
  #     where('available_modules.id in (?) or always_displayed = 1', ids.empty? ? '-1' : ids)
  # }
  scope :for_lang, -> (lang_id = 0) {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.lang_id = ? or static_modules.lang_id is null', lang_id)}
  # scope :for_lang_without_always_displayed, -> (lang_id = 0) {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.lang_id = ? and always_displayed = ?', lang_id, false)}
  # scope :for_lang_with_always_displayed, -> (lang_id = 0) {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.lang_id = ?', lang_id)}
  scope :always_displayed, -> {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.always_displayed = ?', true)}
  # scope :with_always_displayed, -> {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.always_displayed = ?', true)}
  

  def module_title
    static_module.title
  end

  def static_module_id
    static_module.id
  end

  def lang_id
    static_module.lang_id
  end

  def displayed?
    static_module.displayed?
  end
end
