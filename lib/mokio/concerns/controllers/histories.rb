module Mokio
  module Concerns
    module Controllers
      module Histories
        extend ActiveSupport::Concern

        def get_n_more
          @histories = load_next_n(params, 5)

          respond_to do |format|
            format.js.slim
          end
        end

        private
          def find_obj(params)
            obj_id = params[:obj_id]
            obj_type = params[:obj_type]
            obj_type.constantize.find(obj_id)
          end

          def load_next_n(params, n)
            last_loaded_date = params[:last_loaded_date]
            obj = find_obj(params)
            obj.get_next_n_histories(last_loaded_date, n)
          end
      end
    end
  end
end