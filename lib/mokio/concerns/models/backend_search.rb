module Mokio
    module Concerns
      module Models
        #
        # Concern for Contact model
        #
        module BackendSearch
          extend ActiveSupport::Concern

          included do
            # delegate :tpl, to: :contact_template
          end

          include ActiveModel::Validations
          include ActiveModel::Conversion
          include ActiveModel::Model

          extend ActiveModel::Naming

          attr_accessor :id,:search_name, :search_model_name ,:search_model_id,:per_page

          module ClassMethods
            #
            # Columns for table in CommonController#index view
            #
            def columns_for_table
              # full_list: search_model_id search_name search_model_name active created_at
              %w(search_model_id search_name search_model_name active created_at )
            end
          end

          def initialize(attributes = {})
            attributes.each do |name, value|
              send("#{name}=", value)
            end
          end

          def persisted?
            false
          end

          def search_model_name_view
            I18n.t("mokio_model_names.#{self.search_model_name}")
          end

          def created_at_view
            self_object_value("created_at_view")
          end

          def active_view
            return no_data_message unless self_object.respond_to?('active')
            active_value = self_object_value("active")
            return active_value if ![true, false].include? active_value
            return ApplicationController.helpers.active_view_switch_helper(active_value,self_object)
          end

          def self_object
            get_self_object
          end

          def self_object_class
            get_self_object_class
          end

          private

          def self_object_value(name)
            self_object = get_self_object
            return (self_object.nil? || !self_object.respond_to?("#{name}") || self_object.send("#{name}").nil?) ? no_data_message : self_object.send("#{name}")
          end

          def get_self_object_class
            self.search_model_name.classify.constantize rescue nil
          end

          def get_self_object
            get_self_object_class.find(self.search_model_id) rescue nil
          end

          def no_data_message
            I18n.t('backend.no_data')
          end

        end
      end
    end
  end