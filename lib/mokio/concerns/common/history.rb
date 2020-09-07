module Mokio
  module Concerns
    module Common

      module History
        module Controller
          extend ActiveSupport::Concern
          private
            def history_mark(obj)
              obj.logged_editor = current_user if obj.respond_to?('has_historable_enabled?') && obj.class.has_historable_enabled?
            end
        end

        module Model
          extend ActiveSupport::Concern

          included do
            has_many :histories, as: :historable, :class_name => 'Mokio::History'
            before_update :update_history
            attr_accessor :logged_editor

            def logged_editor
              @logged_editor
            end

            def logged_editor=(v)
              @logged_editor = v
            end

            def history_collection
              self.histories.order(changed_at: :desc).group_by { |x| x.changed_at.strftime("%c") }
            end

            def get_first_n_histories(n)
              self.history_collection.first(n)
            end

            def get_next_n_histories(date, n)
              self.history_collection.select{|k, v| k < date}.first(n)
            end

            def history_inputs_exclude
              %w(updated_at)
            end
          private

          def update_history
            if self.class.has_historable_enabled? && self.changed?
              assoc = self.class.reflect_on_all_associations(:belongs_to).map{|b| [b.foreign_key.to_sym,b.name]}.to_h

              logged_editor_email = (@logged_editor.present?) ? @logged_editor.email : nil

              self.changes.each do |key,value|
                next if history_inputs_exclude.include?(key)
                input_value_before = value[0]
                input_value_current = value[1]

                Mokio::History.create(
                  before_value: input_value_before,
                  current_value: input_value_current,
                  field: key,
                  historable_type: self.class.base_class.name,
                  historable_id:  self.id,
                  changed_at: DateTime.now,
                  user_email: logged_editor_email
                )
              end
            end
          end
        end

          module ClassMethods
            def has_historable_enabled?
              (self.respond_to?("historable_enabled?")) ? self.historable_enabled? : true
            end

            def has_historable_displayed?
              (self.respond_to?("historable_displayed?")) ? self.historable_displayed? : true
            end
          end
        end
      end
    end
  end
end