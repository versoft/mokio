module Mokio
  module Concerns 
    module Common 
      #
      # Most important logic for CommonController
      #
      module ControllerObject
        extend ActiveSupport::Concern

        included do
          before_filter :set_obj_class
          before_action :set_obj, only: [:update, :destroy, :edit, :show, :copy, :update_active]
          
          helper_method :obj # Method obj must be also a helper method for usage in views 
        end

        private
          #
          # Returns inherited conroller singularized name 
          #
          def obj_name #:doc:
            self.controller_name.singularize
          end

          #
          # Creates an instance variable named as controller
          #
          # ==== Examples
          #  # for articles_controller:
          #  create_obj(value) # => @article = value
          #
          def create_obj(value) #:doc:
            instance_variable_set("@#{obj_name}", value)
          end

          #
          # Returns variable named as controller.
          # Example for articles_controller:
          #   obj # => @article
          #
          # You can work on variable for every controller.
          #
          # ==== Examples
          #   # for articles_controller:
          #   obj.each # => @article.each
          #
          #   # but for examples_controller
          #   obj.each # => @example.each
          #
          #   # Thats important in case of override some Common action in your controller, but still use Common views, you might want use correct variable
          #   # example for examples_controller:
          #   def new
          #     @example = ExampleModel.new
          #     @example.something = true
          #   end
          #
          # This method is also a <b>helper_method</b> so can be used in views as well
          #   form_for obj # ....
          #
          def obj #:doc:
            eval("@#{obj_name}")
          end

          #
          # <b>before_action</b> for :update, :destroy, :edit, :show, :copy, :update_active actions
          #
          def set_obj #:doc:
            create_obj( @obj_class.respond_to?(:friendly) ? @obj_class.friendly.find(params[:id]) : @obj_class.find(params[:id]) )
          end

          
          #
          # Setting constant parsed from controller name to @obj_class variable.
          # Our controllers are named to match model name. <b>before_filter</b> in CommonController
          #
          def set_obj_class #:doc:
            @obj_class = "Mokio::#{self.class.name.demodulize.gsub("Controller", "").classify}".constantize
          end

          #
          # Call your_controller_params
          #
          def obj_params #:doc:
            send("#{obj_name}_params")
          end

          #
          # Returns obj title or name
          #
          def obj_title #:doc:
            obj.has_attribute?( :title ) ? obj.title : obj.name
          end
      end
    end
  end
end