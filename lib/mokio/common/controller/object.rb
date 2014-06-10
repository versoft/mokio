module Mokio
  module Common
    module Controller
      #                                                                     #
      # ========================== module Object ========================== #
      #                                                                     #
      module Object
        def self.included(base)
          base.before_filter :set_obj_class
          base.before_action :set_obj, only: [:update, :destroy, :edit, :show, :copy, :update_active]
          
          base.helper_method :obj # Method obj must be also a helper method for usage in views
          
          private
            def obj_name
              self.controller_name.singularize
            end

            #
            # Creates an instance variable named as controller
            # example for articles_controller:
            # => @article = value
            #
            def create_obj(value)
              instance_variable_set("@#{obj_name}", value)
            end

            #
            # Returns variable named as controller
            # example for articles_controller:
            #   obj
            # => @article
            #
            # You can work on variable for every controller
            # ex:
            # for articles_controller:
            #   obj.each
            # => @article.each
            #
            # but for examples_controller
            # => @example.each
            #
            # Thats important in case of override some Common action in your controller, but still use Common views, you might want use correct variable
            # example for examples_controller:
            #  def new
            #    @example = ExampleModel.new
            #    @example.something = true
            #  end
            #
            def obj
              eval("@#{obj_name}")
            end

            def set_obj
              create_obj( @obj_class.respond_to?(:friendly) ? @obj_class.friendly.find(params[:id]) : @obj_class.find(params[:id]) )
            end

            def set_obj_class
              @obj_class = self.class.name.demodulize.gsub("Controller", "").classify.constantize
            end

            def obj_params
              send("#{obj_name}_params") # call your_controller_params
            end

            def obj_title
              obj.has_attribute?( :title ) ? obj.title : obj.name
            end
        end
      end
    end
  end
end