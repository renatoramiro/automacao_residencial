class api::v1::ServicesController < ApplicationController
  before_action :set_service, only: [:turn]

  def turn
    if @service.status
      @service.status = false
    else
      @service.status = true
    end

    respond_to do |format|
      if @service.save
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:service_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:status)
    end
end
