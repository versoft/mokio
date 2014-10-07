module Mokio
  module Concerns
    module Controllers
      #
      # Concern for YoutubesController
      #
      module Youtubes
        extend ActiveSupport::Concern

        included do
          before_filter :set_edited_gallery, :only => [:create, :update, :find]
          before_filter :set_edited_movie, :only => [:edit, :update, :preview_movie]
        end

        #
        # Standard create action
        #
        def create
          @youtube = Mokio::Youtube.new(youtube_params)

          #
          # TODO: move it into model
          #
          if !Mokio::Youtube.where(content_id: params[:youtube][:content_id]).blank?
            lastseq = Mokio::Youtube.where(content_id: params[:youtube][:content_id]).last.seq
            @youtube.seq = lastseq.to_i + 1
          else
            @youtube.seq = 1
          end

          @youtube.thumb = @youtube.thumb.file
        
          if @youtube.save
            flash[:notice] = t("youtubes.created", title: @youtube.name).html_safe
          else
            flash[:error]  = t("youtubes.created", title: @youtube.name).html_safe
          end

          redirect_to edit_content_path(@edited_gallery) 
        end

        #
        # Standard edit action
        #
        def edit
          @youtube = Mokio::Youtube.friendly.find(params[:id])

          if stale?(:etag => @youtube, :last_modified => @youtube.updated_at, :public => true)
            @video = Mokio::Youtube.find_movie(@youtube.movie_url)
            render :partial => 'edit'
          end
        end

        #
        # Add Movie - form for entering URL of a film
        #
        def load_new_form
          @content_id = params[:id]
          render :partial => 'new'
        end

        #
        # Standard update action
        #
        def update
          respond_to do |format|
            if @edited_movie.update(youtube_params)
              format.html { redirect_to edit_content_path(@edited_gallery), notice: t("youtubes.updated", title: @edited_movie.name )}
              format.json { head :no_content }
            else
              format.html { render "edit", notice: t("youtubes.not_updated", title: @edited_movie.name) }
              format.json { render json: @edited_movie.errors, status: :unprocessable_entity }
            end
          end
        end

        #
        # Searches for a movie on Youtube, Vimeo or Dailymotion based on given URL.
        # Renders preview.html.haml 
        #
        def find
          @youtube = Mokio::Youtube.new
          @yt = params[:yt]
          @content_id = @edited_gallery.id
          @video = Mokio::Youtube.find_movie(@yt)
          respond_to do |format|
            format.js
          end
        end

        #
        # Standard destroy action
        #
        def destroy
          @youtube = Mokio::Youtube.friendly.find(params[:id])
          @youtube.destroy
          flash[:notice] = t("youtubes.deleted", title: @youtube.name).html_safe

          respond_to do |format|
            format.json { head :no_content }
          end
        end

        #
        # Opens a window with a movie based on the movie URL 
        #
        def preview_movie
          @video = Mokio::Youtube.find_movie(@edited_movie.movie_url)
          respond_to do |format|
            format.js
          end
        end

        private
          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #   
          def youtube_params #:doc:
            params.require(:youtube).permit(:name, :intro, :external_link, :active, :content_id, :movie_url, :id, :thumb, :subtitle, :thumb_external_url)
          end

          #
          # Setting @edited_gallery for params[:youtube][:content_id] or params[:content_id]
          #
          def set_edited_gallery #:doc:
            if params[:content_id].blank?
              @edited_gallery = Mokio::MovGallery.find(params[:youtube][:content_id])
            else
              @edited_gallery = Mokio::MovGallery.find(params[:content_id])
            end
          end

          #
          # Setting @edited_movie for params[:id]
          #
          def set_edited_movie #:doc:
            @edited_movie = Mokio::Youtube.friendly.find(params[:id]) unless params[:id].blank?
          end
      end
    end
  end
end