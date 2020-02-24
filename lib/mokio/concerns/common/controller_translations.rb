module Mokio
  module Concerns
    module Common #:nodoc:
      module Translations #:nodoc:
        #
        # This is not exactly the concern but placed here to have all CommonController extensions in one place
        #
        class CommonTranslation
          def self.created(obj)
            I18n.t("#{class_name(obj)}.created", title: obj_title(obj))
          end

          def self.not_created(obj)
            I18n.t("#{class_name(obj)}.not_created", title: obj_title(obj))
          end

          def self.updated(obj)
            I18n.t("#{class_name(obj)}.updated", title: obj_title(obj))
          end

          def self.not_updated(obj)
            I18n.t("#{class_name(obj)}.not_updated", title: obj_title(obj))
          end

          def self.deleted(obj)
            I18n.t("#{class_name(obj)}.deleted", title: obj_title(obj))
          end

          def self.not_deleted(obj)
            I18n.t("#{class_name(obj)}.not_deleted", title: obj_title(obj))
          end

          def self.update_active_true(obj)
            I18n.t("#{update_active_translation(obj)}.update_active_true", title: obj_title(obj))
          end

          def self.update_active_false(obj)
            I18n.t("#{update_active_translation(obj)}.update_active_false", title: obj_title(obj))
          end

          def self.password_not_match(obj)
            I18n.t("#{class_name(obj)}.password_not_match_remove_failed", title: obj_title(obj))
          end

          private

            def self.obj_title(obj)
              obj.has_attribute?( :title ) ? obj.title : obj.name
            end

            def self.update_active_translation(obj)
              if obj.respond_to?("type")
                translation = obj.type.tableize.gsub("mokio/", "")
              else
                translation = obj.class.to_s.tableize.gsub("mokio/", "")
              end
              translation
            end

            def self.class_name(obj) #:doc:
              obj.class.to_s.tableize.gsub("mokio/", "")
            end
        end
      end
    end
  end
end