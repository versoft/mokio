module Mokio
  module Common
    module Controller
      #                                                                           #
      # ========================== module Translations ========================== #
      #                                                                           #
      module Translations
        class CommonTranslation
          def self.created(obj)
            I18n.t("#{obj.class.to_s.tableize}.created", title: obj_title(obj))
          end

          def self.not_created(obj)
            I18n.t("#{obj.class.to_s.tableize}.not_created", title: obj_title(obj))
          end

          def self.updated(obj)
            I18n.t("#{obj.class.to_s.tableize}.updated", title: obj_title(obj))
          end

          def self.not_updated(obj)
            I18n.t("#{obj.class.to_s.tableize}.not_updated", title: obj_title(obj))
          end

          def self.deleted(obj)
            I18n.t("#{obj.class.to_s.tableize}.deleted", title: obj_title(obj))
          end

          def self.update_active_true(obj)
            I18n.t("#{update_active_translation(obj)}.update_active_true", title: obj_title(obj))
          end

          def self.update_active_false(obj)
            I18n.t("#{update_active_translation(obj)}.update_active_false", title: obj_title(obj))
          end

          private

            def self.obj_title(obj)
              obj.has_attribute?( :title ) ? obj.title : obj.name
            end

            def self.update_active_translation(obj)
              if obj.respond_to?("type")
                translation = obj.type.tableize
              else
                translation = obj.class.to_s.tableize
              end
              translation
            end
        end
      end
    end
  end
end