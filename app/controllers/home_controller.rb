class HomeController < ApplicationController
	layout 'admin'
  def index
  	@services = Service.all
  end
end
