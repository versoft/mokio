module Mokio
  module Concerns
    module Controllers
      #
      # Concern for LangsController
      #
      module Langs
        extend ActiveSupport::Concern

        included do
        end


        def create
          @lang = Mokio::Lang.new(lang_params)

          if success = @lang.save
            @menu = Array.new
            @menu[0] = Mokio::Menu.new( name: @lang.shortname , lang_id: @lang.id,fake:true)
            @menu[1] = Mokio::Menu.new( name: 'top',ancestry:@menu[0].id, lang_id: @lang.id,fake:true)
            @menu.each do |obj|
              obj.build_meta
              obj.save(:validate => false)
            end
          end

          redirect_to controller: :langs
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #

        def lang_params #:doc:
            params[:lang].permit(:name,:shortname,:active,:menu_id)
        end
      end
    end
  end
end
