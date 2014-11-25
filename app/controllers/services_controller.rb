class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        @services = Service.all
        format.js
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service }
      else
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        @services = Service.all
        format.js
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    @services = Service.all
    respond_to do |format|
      format.js
      format.html { redirect_to services_url }
      format.json { head :no_content }
    end
  end

  def turn
    @service = Service.find(params[:service_id])

    respond_to do |format|
      puts '###################################################'
      puts "Servico #{@service.title}"
      puts 'Executar comando de envio'
      # require 'serialport'
      port_str  = '/dev/tty.usbserial-A602YXUW'
      # port_str  = '/dev/tty.usbmodemfd121'
      baud_rate = 57600
      data_bits = 8
      stop_bits = 1
      parity    = SerialPort::NONE

      sp = SerialPort.new(port_str, baud_rate)#, data_bits, stop_bits, parity)
      sp.write("20200")

      puts '###################################################'
      @services = Service.all
      format.js
    end
  end

  def executar
    begin
      @service = Service.where(code_out: params[:service_id]).first
    rescue ActiveRecord::RecordNotFound
      puts 'Deu zebra'
    else
      if @service.status
        @service.status = false
      else
        @service.status = true
      end

      respond_to do |format|
        if @service.save
          puts '###################################################'
          #system('ruby /Users/renatoramiro/Documents/teste.rb')
          puts '###################################################'
          @services = Service.all
          format.js
        else
          format.html { render action: 'edit' }
          format.json { render json: @service.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :code, :description, :status, :code_out)
    end
end
