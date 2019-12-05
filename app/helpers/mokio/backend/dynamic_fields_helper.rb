module Mokio
  module Backend
    module DynamicFieldsHelper

      def dynamic_fields_link_to_add_row(f, association, **args)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        partial = args[:partial] || association.to_s.singularize
        add_new_button_value = args[:add_new_button_value] || I18n.t('backend.dynamic_fields.add_new_button')
        css_class = args[:add_button_class] || "btn btn-primary"

        fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
          if block_given?
            yield builder
          else
            render(partial, form_obj: builder)
          end
        end
        link_to(add_new_button_value, '#',class: "add_fields " + css_class, data: {id: id, form: association,fields: fields.gsub("\n", "")})
      end

      def dynamic_fields_render_part(obj,**args)
        partial = args[:partial] || association.to_s.singularize
        render "#{partial}", form_obj: obj
      end

      # form_obj: main form builder object
      # association: has_many association name (sym)
      # args:
      # partial: partial name with fields ( default association_name ")
      # fields_container_class: css class for container when partials views should be loaded
      # container_id: main container id for dynamic fields
      # table_view: true/false - table html tags
      # delete_button_class: css class
      # add_button_class: add new row css class
      # add_new_button_value: text in button add
      # delete_row_button_value: Text in button delete
      # delete_row_button_message_value: Confirmation message

      def dynamic_fields_render_all(form_obj,association,**args,&block)
        partial = args[:partial] || association.to_s.singularize
        fields_container_class = args[:fields_container_class] || "dynamic_fields_container_fields"
        container_id = args[:container_id] || "#{association.to_s.singularize}_container"

        content_rows = form_obj.simple_fields_for association do |builder_object|
          if block_given?
            yield builder_object
          else
            dynamic_fields_render_part builder_object,partial: "#{partial}"
          end
        end

        content = content_tag(:div,class: fields_container_class) do
          content_rows
        end

        if(args[:table_view])
          content = content_tag(:table,class: "table") do
            content_tag(:tbody,class: fields_container_class) do
              content_rows
            end
          end
        end

        add_row = content_tag('div',class: 'form-actions') do
          dynamic_fields_link_to_add_row(form_obj, association, class: 'btn btn-primary',partial: "#{partial}",&block)
        end

        content << add_row

        main_content = content_tag(:div,id: container_id) do
          content
        end

        main_content << javascript_tag("backend_dynamic_fields('##{container_id}')")
        main_content
      end

      def dynamic_fields_render_delete(form_obj,**args)
        css_class = args[:delete_button_class] || "btn btn-primary"
        delete_row_button_value = args[:delete_row_button_value] || I18n.t('backend.dynamic_fields.delete_row_button')
        confrimation_message = args[:delete_row_button_message_value] || I18n.t('backend.dynamic_fields.delete_row_button_message')

        content = form_obj.hidden_field :_destroy
        content << link_to(delete_row_button_value, '#', data: { message: confrimation_message } ,class: "dynamic_fields_remove_row #{css_class}")
      end

    end
  end
end
