module Mokio
  #                                                                            #
  # ========================== module Common::Model ========================== #
  #                                                                            #
  module Common
    module Model
      @date_attributes = %w(display_from display_to updated_at created_at)
      
      def self.included(base)
        base.scope :active,        -> { where(active: true) }
        base.scope :order_default, -> { order("seq asc")    }

        base.before_destroy :deletable
        base.validate  :some_editable
        base.before_save :complete_meta

        ## For Sunspot Solr:
          if Mokio::SolrConfig.enabled
            exceptions = Mokio::SolrConfig.exceptions # Classes which are excluded from indexing or have own searchable method
            
            unless exceptions.include? base.name.downcase.to_sym
              base.searchable do ## Columns where Sunspot knows which data use to index
                text :title, :boost => 5
                text :content, :intro
              end
            end
          end
        ##

        def base.has_gmap_enabled?
          Mokio.backend_gmap_enabled.include?(self.name)
        end

        def base.has_meta_enabled?
          Mokio.backend_meta_enabled.include?(self.name)
        end

        attr_accessor :empty_meta
      end

      def active_view
        "<div class=\"activebutton\">
          <input type=\"checkbox\" 
            #{"checked=\"checked\"" if self.active} 
            class=\"activebtn switch-small\"
            data-on=\"success\"
            data-off=\"danger\"
            data-on-label=\"<i class='icomoon-icon-checkmark white'></i>\" 
            data-off-label=\"<i class='icomoon-icon-cancel-3 white'></i>\"
          >
        </div>"
        .html_safe
      end

      @date_attributes.each do |d|
        define_method "#{d}_view" do
          self[d.to_sym].strftime("%d-%m-%Y") unless self[d.to_sym].nil?
        end
      end

      def lang_id_view
        return I18n.t('backend.' + Lang.find(self.lang_id).name) unless self.lang_id.nil?
        return I18n.t('backend.all') if self.lang_id.nil?
      end

      def displayed?
        (((!display_from.nil? && display_from <= Date.today ) || display_from.nil?) && ((!display_to.nil? && display_to >= Date.today ) || display_to.nil?))
      end

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

      def complete_meta
        if self.class.has_meta_enabled?
          self.empty_meta = true if self.meta.present? && (self.meta.g_title.blank? || self.meta.f_title.blank? || self.meta.g_application_name.blank?)

          application_name = Rails.application.class.to_s.split("::").first 
          self.meta.g_title            = self.title       if self.meta.present? && self.meta.g_title.blank?
          self.meta.f_title            = self.title       if self.meta.present? && self.meta.f_title.blank?
          self.meta.g_application_name = application_name if self.meta.present? && self.meta.g_application_name.blank?

          if self.respond_to?(:intro) && self.intro.present?
            intro = ActionController::Base.helpers.strip_tags(self.intro).truncate(160).gsub!(/\s+/, ' ')
            self.meta.g_desc = intro if self.meta.present? && self.meta.g_desc.blank?
            self.meta.f_desc = intro if self.meta.present? && self.meta.f_desc.blank?
          end
        end
      end
    end
  end
end