module Mokio
  class Backend::YoutubesController < Backend::BaseController
    
    before_filter :set_edited_gallery, :only => [:create, :update, :find]
    before_filter :set_edited_movie, :only => [:edit, :update, :preview_movie]
    
    def create
      @youtube = Youtube.new(youtube_params)

      #
      # TODO: move it into model
      #
      if !Youtube.where(content_id: params[:youtube][:content_id]).blank?
        lastseq = Youtube.where(content_id: params[:youtube][:content_id]).last.seq
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

      redirect_to edit_backend_content_path(@edited_gallery) 
    end

    def edit
      @youtube = Youtube.friendly.find(params[:id])

      if stale?(:etag => @youtube, :last_modified => @youtube.updated_at, :public => true)
        @video = Youtube.find_movie(@youtube.movie_url)
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

    def update
      respond_to do |format|
        if @edited_movie.update(youtube_params)
          format.html { redirect_to edit_backend_content_path(@edited_gallery), notice: t("youtubes.updated", title: @edited_movie.name )}
          format.json { head :no_content }
        else
          format.html { render "edit", notice: t("youtubes.not_updated", title: @edited_movie.name) }
          format.json { render json: @edited_movie.errors, status: :unprocessable_entity }
        end
      end
    end

    # Searches for a movie on Youtube, Vimeo or Dailymotion based on given URL
    # renders preview.html.haml 
    def find
      @youtube = Youtube.new
      @yt = params[:yt]
      @content_id = @edited_gallery.id
      @video = Youtube.find_movie(@yt)
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @youtube = Youtube.friendly.find(params[:id])
      @youtube.destroy
      flash[:notice] = t("youtubes.deleted", title: @youtube.name).html_safe

      respond_to do |format|
        format.json { head :no_content }
      end
    end

    # opens a window with a movie based on the movie URL 
    def preview_movie
      @video = Youtube.find_movie(@edited_movie.movie_url)
      respond_to do |format|
        format.js
      end
    end

    private      
      def youtube_params
        params.require(:youtube).permit(:name, :intro, :external_link, :active, :content_id, :movie_url, :id, :thumb, :subtitle, :thumb_external_url)
      end

      def set_edited_gallery
        if params[:content_id].blank?
          @edited_gallery = MovGallery.find(params[:youtube][:content_id])
        else
          @edited_gallery = MovGallery.find(params[:content_id])
        end
      end

      def set_edited_movie
        @edited_movie = Youtube.friendly.find(params[:id]) unless params[:id].blank?
      end
  end
end