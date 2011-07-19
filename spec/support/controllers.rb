# encoding: UTF-8

class GaragesController < ActionController::Base
  def index
    @garages = Garage.all

    respond_to do |format|
      format.json do 
        render :json => @garages.from_materialized(:profile => :name)
      end
    end
  end

  def show
    @garage = Garage.find(params[:id])

    respond_to do |format|
      format.json do 
        render :json => @garage.from_materialized(:profile => :name)
      end
    end
  end
end
