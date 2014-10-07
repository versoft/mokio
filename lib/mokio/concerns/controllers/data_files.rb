module Mokio
  module Concerns
    module Controllers
      #
      # Concern for DataFilesController
      # 
      module DataFiles
        extend ActiveSupport::Concern

        included do
          before_filter :data_file, only: [:edit, :update, :destroy]

          load_and_authorize_resource
        end

        #
        # TODO: Probably don't need index for now
        #
        def index #:nodoc:
          @data_file = Mokio::DataFile.all

          respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @data_file.map{|upload| upload.to_jq_upload } }
          end
        end

        #
        # Standard new action
        #
        def new
          @data_file = Mokio::DataFile.new

          respond_to do |format|
            format.html
            format.json { render json: @data_file }
          end
        end

        #
        # Standard edit action
        #
        def edit
        end

        #
        # Standard update action
        #
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


        #
        # Standard destroy action
        #
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
            file = Mokio::DataFile.find(id)
            file.update_attribute(:seq, sequence)
            sequence += 1
          end

          flash[:notice] = t('data_files.sorted')

          render nothing: true
        end

        private
          #
          # before_filter finding datafile by id
          #
          def data_file #:doc:
            @data_file = Mokio::DataFile.find(params[:id])
          end

          #
          # Never trust parameters from the scary internet, only allow the white list through.
          #
          def data_file_params #:doc:
             params.require(:data_file).permit(:content_id, :data_file)
          end
      end
    end
  end
end