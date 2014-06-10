module Mokio
  class Backend::PhotosController < Backend::BaseController
    before_filter :edited_photo, only: [:get_thumb, :update_thumb, :remove_thumb, :crop_thumb, :rotate_thumb,
                                        :get_photo, :rotate_photo, :crop_photo]

    #
    # TODO: Is it realy required?
    #
    load_and_authorize_resource
    
    def create
      @photo = Photo.new(photo_params)

      respond_to do |format|
        if @photo.save
          flash[:notice] = t("photos.created", title: @photo.name)
          format.js
        else
          flash[:error] = t("photos.not_created", title: @photo.name)
          format.html { render nothing: true }
        end
      end
    end

    def upload_external_links
      urls    = params[:photo][:remote_data_file_url].split("\n")
      error   = t("photos.photos_from_external_links_error")
      notice  = ""
      @photos = []

      #
      # split with "\n" can create "empty" string with '\r', when parsing textarea parameter
      # we don't want to have them in loop
      #
      urls.reject! {|u| u == "\r"} 
                                   
      if urls
        urls.each do |url|
          url = url.gsub(/,/, '')

          begin
            uri = URI.parse(url)
            raise URI::InvalidURIError unless uri.scheme == "http" || uri.scheme == "https"

            #
            # Carrierwave use Kernel.open to find file in url which is very slow when url is wrong
            # Check first if url status will be 200 and then try upload this file
            #
            if Faraday.head(url).status == 200
              photo = Photo.new(:remote_data_file_url => url, :content_id => params[:photo][:content_id]) # remote_data_file_url is Carrierwave parameter for adding file from url
              
              if photo.save # !!!
                @photos << photo
                notice += "#{t("photos.created", title: photo.name)}\n"
              else
                raise "[Photo Save] Photo not saved"
              end
            else
              raise "[Faraday Gem Status] Faraday head status != 200"
            end

          #
          # TODO: lets do it smarter way
          #
          rescue Exception => e
            error += "\n#{url}"
            logger.error e.message # becaouse we catach all exceptions we have to at least log them
          end
        end
      end

      #
      # we can have both error and notice messages so only those cases
      #
      flash[:error]  = error  unless error == t("photos.photos_from_external_links_error") 
      flash[:notice] = notice unless notice.blank?

      respond_to do |format|
        format.js
      end
    end

    def destroy
      @id = params[:id]
      @photo = Photo.friendly.find(@id)
      
      if @photo.destroy
        flash[:notice] = t("photos.deleted", title: @photo.name)
      else
        flash[:error] = t("photos.not_deleted", title: @photo.name)
      end
      
      respond_to do |format|
        format.js
      end
    end

    def update
      @photo = Photo.friendly.find(params[:id])

      if @photo.update(photo_params)
        flash[:notice] = t("photos.updated", title: @photo.name)
      else
        flash[:error] = t("photos.not_updated", title: @photo.name)
      end

      respond_to do |format|
        format.html { render nothing: true }
      end
    end

    # 
    # Ajax methods below
    # ========================
    # load thumb to html [GET]
    #
    def get_thumb
      if stale?(:etag => @edited_photo, :last_modified => @edited_photo.updated_at, :public => true)
        respond_to do |format|
          format.js
        end
      end
    end

    #
    # crop thumb [POST]
    #
    def crop_thumb
      begin
        image_path = thumb_path

        img = MiniMagick::Image.open(image_path)

        img.crop("#{params[:w]}x#{params[:h]}+#{params[:x]}+#{params[:y]}")
        img.write image_path

        if @edited_photo.thumb.recreate_versions!
          flash[:notice] = t("photos.crop", name: @edited_photo.name)
          @edited_photo.touch
        else
          flash[:error] = t("photos.not_crop", name: @edited_photo.name)
        end
      #
      # when MiniMagick.open failed, continue action with only error message for user, this prevent redirect to 500 in this case
      #
      rescue Errno::ENOENT
        flash[:error] = t("photos.not_crop", name: @edited_photo.name) 
        logger.error errno_enoent_exception_msg(image_path)
      end

      respond_to do |format|
        format.js
      end 
    end

    #
    # rotate thumb [GET]
    #
    def rotate_thumb
      begin
        image_path = thumb_path

        img = MiniMagick::Image.open(image_path)
        img.rotate "90"
        img.write image_path

        if @edited_photo.thumb.recreate_versions!
          flash[:notice] = t("photos.rotated_thumb", name: @edited_photo.name)
          @edited_photo.touch
        end
      #
      # when MiniMagick.open failed, continue action with only error message for user, this prevent redirect to 500 in this case
      #
      rescue Errno::ENOENT
        flash[:error] = t("photos.not_rotated_thumb", name: @edited_photo.name)
        logger.error errno_enoent_exception_msg(image_path)
      end

      respond_to do |format|
        format.js
      end
    end

    #
    # update thumb params [PATCH]
    #
    def update_thumb
      if @edited_photo.update(photo_params)
        flash[:notice] = t("photos.thumb_updated")
        @edited_photo.touch
      else
        flash[:error] = t("photos.thumb_not_updated")
      end

      respond_to do |format|
        format.js
      end
    end

    #
    # remove thumb [DELETE]
    #
    def remove_thumb
      @edited_photo.remove_thumb = true
      
      if @edited_photo.save!
        flash[:notice] = t("photos.thumb_deleted", name: @edited_photo.name)
        @edited_photo.touch
      else
        flash[:error] = t("photos.thumb_not_deleted", name: @edited_photo.name)
      end

      respond_to do |format|
        format.js 
      end
    end

    #
    # load photo to html [GET]
    #
    def get_photo
      if stale?(:etag => @edited_photo, :last_modified => @edited_photo.updated_at, :public => true)
        respond_to do |format|
          format.js
        end
      end
    end

    #
    # crop photo [POST]
    #
    def crop_photo
      begin
        image_path = "#{Rails.root}/public#{@edited_photo.data_file.url}"
        img = MiniMagick::Image.open(edited_photo_path(:normal))

        width = Mokio.photo_thumb_width
        height = Mokio.photo_thumb_height

        img.crop("#{params[:w]}x#{params[:h]}+#{params[:x]}+#{params[:y]}")
        img.resize "#{width}x#{height}"
        img.write edited_photo_path(:thumb)

        flash[:notice] = t("photos.crop", name: @edited_photo.name)

        @edited_photo.touch
      #
      # when MiniMagick.open failed, continue action with only error message for user, this prevent redirect to 500 in this case
      #
      rescue Errno::ENOENT
        flash[:error] = t("photos.not_crop", name: @edited_photo.name)
        logger.error errno_enoent_exception_msg(image_path)
      end

      respond_to do |format|
        format.js
      end 
    end

    #
    # rotate photo [GET]
    #
    def rotate_photo
      begin
        image_path = "#{Rails.root}/public#{@edited_photo.data_file.url}"

        img = MiniMagick::Image.open(image_path)
        img.rotate "90"
        img.write image_path

        if @edited_photo.data_file.recreate_versions!
          flash[:notice] = t("photos.rotated", name: @edited_photo.name)
          @edited_photo.touch
        else
          flash[:error] = t("photos.not_rotated", name: @edited_photo.name)
        end
      #
      # when MiniMagick.open failed, continue action with only error message for user, this prevent redirect to 500 in this case
      #
      rescue Errno::ENOENT
        flash[:error] = t("photos.not_rotated", name: @edited_photo.name)
        logger.error errno_enoent_exception_msg(image_path)
      end

      respond_to do |format|
        format.js
      end
    end

    private
      #
      # TODO: move data_file attributes to one method
      #
      def photo_params
        params.require(:photo).permit(:name, :subtitle, :intro, :external_link, :thumb, :active, :content_id, :data_file, :remote_data_file_url, :seq)
      end

      def edited_photo
        @edited_photo = Photo.friendly.find(params[:id])
      end

      def edited_photo_path(type = "")
        "#{Rails.root}/public#{@edited_photo.data_file.url(type)}"
      end

      def thumb_path
        "#{Rails.root}/public#{@edited_photo.thumb.url}"
      end

      def errno_enoent_exception_msg(path)
        "[Errno::ENOENT] cannot open #{path}"
      end
  end
end