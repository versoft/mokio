module Mokio
  module Concerns
    module Models
      #
      # Common module add's methods commonly used in our models
      #
      module Common
        extend ActiveSupport::Concern

        #
        # Constant with <b>[display_from display_to updated_at created_at]</b> attributes.
        # We dynamicly create additional <b>date_atribute</b>_view methods from this one
        #
        DATE_ATTRIBUTES = %w(display_from display_to updated_at created_at)

        included do

          scope :active,        -> { where(active: true) }
          scope :order_default, -> { order("seq asc")    }

          before_destroy :deletable


          validate  :some_editable , on: :update

          #
          # For Sunspot Solr:
          #
          if Mokio.solr_enabled
            exceptions = Mokio::SolrConfig.all_exceptions # Classes which are excluded from indexing or have own searchable method

            unless exceptions.include? self.name.demodulize.downcase.to_sym
              searchable do # Columns where Sunspot knows which data use to index
                text :title, :boost => 5
                text :content, :intro
              end
            end
          end
        end

        module ClassMethods
          #
          # Returns boolean value depends on included model names in Mokio.backend_gmap_enabled
          #
          def has_gmap_enabled?
            Mokio.backend_gmap_enabled.include?(self.name)
          end
        end

        #
        # Output for <b>active</b> parameter, used in CommonController#index
        #
        def active_view
          ApplicationController.helpers.active_view_switch_helper(self.active,self)
        end

        DATE_ATTRIBUTES.each do |d|
          define_method "#{d}_view" do
            self[d.to_sym].strftime("%d-%m-%Y") unless self[d.to_sym].nil?
          end
        end

        #
        # Output for <b>lang_id</b> parameter, used in CommonController#index
        #
        def lang_id_view
          return Mokio::Lang.find(self.lang_id).name unless self.lang_id.nil?
          return I18n.t('backend.all') if self.lang_id.nil?
        end

        #
        # Is object selected as displayed?
        #
        def displayed?
          (((!display_from.nil? && display_from <= Date.today ) || display_from.nil?) && ((!display_to.nil? && display_to >= Date.today ) || display_to.nil?))
        end

        #
        # Table of always editable fields
        #
        def always_editable_fields
          %w(active seq visible always_displayed)
        end

        def some_editable
          if !self.editable && !self.changed.nil?
            (self.changed.to_set - self.always_editable_fields.to_set).each do |field|
              errors.add(field.to_sym, "#{I18n.t('activerecord.errors.editable.not_permitted')}")
            end
          end
        end

        def display_editable_field?(field_name)
          editable || always_editable_fields.include?(field_name)
        end

        #
        # Is object cloneable?
        #
        def cloneable?
          true
        end
      end
    end
  end
end