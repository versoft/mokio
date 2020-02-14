module Mokio
  module Concerns #:nodoc:
    module Common #:nodoc:
      #
      # Additional CommonController methods
      #
      module ControllerFunctions
        extend ActiveSupport::Concern

        included do
          after_action :back_to_edit, only: [:create, :update]
        end

         private
          #
          # <b>after_action</b>, Info message about possible back to edit
          #
          def back_to_edit #:doc:
            if flash[:notice].present?
              flash[:notice] += " #{t("backend.back_to_edit", url: obj_edit_url(obj))}" if obj.id
            end
          end

          def build_enabled(obj)
            obj.build_gmap if obj.class.has_gmap_enabled?
          end

          # @TODO - move here data_files_attributes ?

          #
          # Additional parameters to premit
          #
          def extended_parameters #:doc:
            parameters = {}
            parameters[:gmap_attributes] = Mokio::Gmap.gmap_attributes if @obj_class.has_gmap_enabled?
            if @obj_class.respond_to?(:has_seo_tagable_enabled?) && @obj_class.has_seo_tagable_enabled?
              parameters[:seo_tags_attributes] = Mokio::SeoTag.seo_tag_attributes
            end
            parameters
          end


        def mokio_gems_parameters
          parameters = []
          c_name = self.controller_name.to_sym

          Mokio.mokio_gems_parameters.each do |g,v|
            v.each do |par,val|
              if par == c_name || par == :contents && CONTENT_TYPES.include?("#{controller_path.classify.constantize.name}")
                  parameters += val
              end
            end
          end
          parameters
        end

          def generate_path
            path = @obj_class.name
            path = path.gsub("Mokio::","") if path.include? "Mokio::"
            path = path.tableize.gsub("/","_")
            path
          end

          #
          # Returns obj index url
          #
          def obj_index_url #:doc:
            send("#{generate_path}_url") # call your_controller index path
          end

          #
          # Returns obj edit url
          #
          def obj_edit_url(obj) #:doc:
            Mokio::Content.subclasses.each do |s|
              if "mokio/#{obj_name}" == s.to_s.tableize.singularize
                return send("edit_content_path", obj)
              end
            end
            return "#{Mokio::Engine.routes.url_helpers.root_path}#{obj.class.to_s.tableize.gsub("mokio/", "")}/#{obj.id}/edit"
          end

          #
          # Returns obj new url
          #
          def obj_new_url(obj) #:doc:
            send("new_#{generate_path.singularize}_path", obj) # call your_controller edit path for obj
          end
      end
    end
  end
end