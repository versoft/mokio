class Mokio::SupportController < Mokio::CommonController
  layout "mokio/backend"
  helper :application

  def index
    respond_to do |format|
      format.html
    end
  end


end

