module Mokio
  module Common
    module Controller
      #                                                                        #
      # ========================== module Functions ========================== #
      #                                                                        #
      module Functions
        def self.included(base)
          base.after_action :back_to_edit, only: [:create, :update]
          base.after_action :meta_info, only: [:create, :update]

          private
            def meta_info
              if flash[:notice].present?
                flash[:notice] += " #{t("meta.auto_completed")}" if obj.respond_to?(:empty_meta) && obj.empty_meta && obj.id
              end
            end

            def back_to_edit
              if flash[:notice].present?
                flash[:notice] += " #{t("backend.back_to_edit", url: obj_edit_url(obj))}" if obj.id
              end
            end

            def build_enabled(obj)
              obj.build_gmap if obj.class.has_gmap_enabled?
              obj.build_meta if obj.class.has_meta_enabled?
            end

            # @TODO - move here data_files_attributes ?
            def extended_parameters
              parameters = {}
              parameters[:gmap_attributes] = Gmap.gmap_attributes if @obj_class.has_gmap_enabled?
              parameters[:meta_attributes] = Meta.meta_attributes if @obj_class.has_meta_enabled?
              parameters
            end

            def obj_index_url
              send("backend_#{self.controller_name.demodulize}_url") # call your_controller index path 
            end

            def obj_edit_url(obj)
              Content.subclasses.each do |s|
                if obj_name == s.to_s.tableize.singularize
                  return send("edit_backend_content_path", obj)
                end
              end
              return "/backend/#{obj.class.to_s.tableize}/#{obj.id}/edit"
            end

            def obj_new_url(obj)
              send("new_backend_#{self.controller_name.demodulize.singularize}_path", obj) # call your_controller edit path for obj
            end
        end
      end
    end
  end
end