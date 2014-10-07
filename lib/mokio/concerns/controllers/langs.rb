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

        #
        # Save new lang and generate default lang menu structure to mokio_menus
        #

        def create
          @lang = Mokio::Lang.new(lang_params)

          if success = @lang.save

              menu = Array.new
              @menu = Mokio::Menu.new( name: @lang.shortname , lang_id: @lang.id,fake:true,deletable:false,editable:false)
              @menu.build_meta

          if(success = @menu.save)
              result = Mokio::Menu.fake_structure_unique
              result.each do |pos|
                menu = Mokio::Menu.new( name: pos.name,ancestry:@menu.id, lang_id: @lang.id,fake:true,deletable:false,editable:false)
                menu.save(:validate => false)
              end

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
