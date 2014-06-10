module Mokio
  class Backend::DataFilesController < Backend::BaseController
    before_filter :data_file, only: [:edit, :update, :destroy]
    load_and_authorize_resource
    
    #
    # TODO: Probably don't need index for now
    #
    def index
      @data_file = DataFile.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @data_file.map{|upload| upload.to_jq_upload } }
      end
    end

    def new
      @data_file = DataFile.new

      respond_to do |format|
        format.html
        format.json { render json: @data_file }
      end
    end

    def edit
    end

    def update
      respond_to do |format|
        if @data_file.update_attributes(data_file_params)
          format.html { redirect_to @data_file, notice: 'Upload was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @data_file.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /uploads/1
    # DELETE /uploads/1.json
    def destroy
      @data_file.destroy

      respond_to do |format|
        format.html { render nothing: true }
      end
    end

    #
    # Sorting files
    #
    def sort
      ids = params[:ids_order]
      sequence = 1

      ids.each do |id|
        file = DataFile.find(id)
        file.update_attribute(:seq, sequence)
        sequence += 1
      end

      flash[:notice] = t('data_files.sorted')

      render nothing: true
    end

    private
      def data_file
        @data_file = DataFile.find(params[:id])
      end

      def data_file_params
         params.require(:data_file).permit(:content_id, :data_file)
      end
  end
end