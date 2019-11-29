module Mokio
  module Concerns
    module Controllers
      module BackendSearch
        extend ActiveSupport::Concern

        def index
          set_obj_class
          respond_to do |format|
            format.html # { create_obj(@obj_class.page( params[:page] ) ) }
            format.json { render json: ::DatatableBackendSearch.new(view_context, @obj_class, current_records_array) }
          end
        end

        def current_records_array
          records_array
        end

        private

        def check_value(val)
          val.present? ? val : nil
        end

        def records_array
          value = check_value(params[:query])
          column_method_name = 'backend_search_columns'
          result = []

          Mokio.backend_search_enabled.each do |model|
            model = model.classify.constantize
            id_model = !id_model.nil? ? id_model + 1 : 1

            next unless defined?(model)

            unless model.respond_to?(column_method_name.to_s)
              raise "Missing method self.#{column_method_name}:#{model}"
            end

            columns = model.send(column_method_name.to_s)
            next if !(columns & model.column_names) == columns

            query_value(columns, model, value).each do |r|
              name = r.send(model.send(column_method_name.to_s).first.to_s)

              result << Mokio::BackendSearch.new(
                id: id_model,
                search_name: name,
                search_model_name: model.name,
                search_model_id: r.id
              )
            end
          end
          result
        end

        def query_value(columns, model, value)
          query = ''

          columns.each do |c|
            next unless model.column_names.include?(c.to_s)

            column_type = model.columns_hash[c].type.to_s

            if(column_type == 'integer')
              query << "#{c} = #{value.to_i}"
            else
              query << "#{c} LIKE '%#{value}%'"
            end
            query << ' OR ' unless columns.last == c

          end
          model.where("#{query}")
        end
      end
    end
  end
end
