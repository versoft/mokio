module Mokio
  module Concerns
    module Models
      #
      # Concern for Mokio::AvailableModule model
      #
      module AvailableModule
        extend ActiveSupport::Concern

        included do
          belongs_to :static_module
          belongs_to :module_position

          scope :not_selected_for_menu, -> (menu_id = -1) { 
              ids = Mokio::SelectedModule.where(:menu_id => menu_id).pluck(:available_module_id)
              joins("join mokio_static_modules on mokio_available_modules.static_module_id = mokio_static_modules.id").
              where('mokio_available_modules.id not in (?) and always_displayed = 0', ids.empty? ? '-1' : ids)
          }
          scope :always_displayed, -> {joins("join mokio_static_modules on mokio_available_modules.static_module_id = mokio_static_modules.id").where('mokio_static_modules.always_displayed = ?', true)}
          scope :for_lang, -> (lang_id = 0) {joins("join mokio_static_modules on mokio_available_modules.static_module_id = mokio_static_modules.id").where('mokio_static_modules.lang_id = ? or mokio_static_modules.lang_id is null', lang_id)}

          # acts_as_list :column => :seq, :scope => :module_position
          #
          # scope :selected_for_menu, -> (menu_id = -1) { 
          #     ids = SelectedModule.where(:menu_id => menu_id).pluck(:available_module_id)
          #     joins("join static_modules on available_modules.static_module_id = static_modules.id").
          #     where('available_modules.id in (?) or always_displayed = 1', ids.empty? ? '-1' : ids)
          # }
          # scope :for_lang_without_always_displayed, -> (lang_id = 0) {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.lang_id = ? and always_displayed = ?', lang_id, false)}
          # scope :for_lang_with_always_displayed, -> (lang_id = 0) {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.lang_id = ?', lang_id)}

          scope :only_always_displayed, -> { where('mokio_static_modules.always_displayed = true')}
          scope :static_module_active_for_lang, -> (position_id,lang_id) {
              joins("join mokio_static_modules on mokio_available_modules.static_module_id = mokio_static_modules.id")
              .where('(mokio_static_modules.lang_id = ? AND mokio_static_modules.active = true AND mokio_available_modules.module_position_id = ?) ', lang_id,position_id)
              .select("mokio_static_modules.*,mokio_available_modules.*")
          }

          # scope :with_always_displayed, -> {joins("join static_modules on available_modules.static_module_id = static_modules.id").where('static_modules.always_displayed = ?', true)}
        end

        #
        # Returns static module title
        #
        def module_title
          static_module.title
        end

        #
        # Returns static module id
        #
        def static_module_id
          static_module.id
        end

        #
        # Returns static module lang_id
        #
        def lang_id
          static_module.lang_id
        end

        #
        # Returns true/false depends if static module is marked as displayed
        #
        def displayed?
          static_module.displayed?
        end
      end
    end
  end
end