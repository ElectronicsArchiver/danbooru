class AdvertisementsController < ApplicationController
  def new
    @advertisement = Advertisement.new(
      :ad_type => "vertical",
      :status => "active"
    )
  end
  
  def edit
    @advertisement = Advertisement.find(params[:id])
  end
  
  def index
    @advertisements = Advertisement.all

    if params[:start_date]
      @start_date = Date.parse(params[:start_date])
    else
      @start_date = 1.month.ago.to_date
    end

    if params[:end_date]
      @end_date = Date.parse(params[:end_date])
    else
      @end_date = Date.today
    end
  end
  
  def show
    @advertisement = Advertisement.find(params[:id])
  end
  
  def create
    @advertisement = Advertisement.new(params[:advertisement])
    if @advertisement.save
      flash[:notice] = "Advertisement created"
      redirect_to advertisement_path(@advertisement)
    else
      flash[:notice] = "There were errors"
      render :action => "new"
    end
  end
  
  def update
    @advertisement = Advertisement.find(params[:id])
    if @advertisement.update_attributes(params[:advertisement])
      flash[:notice] = "Advertisement updated"
      redirect_to advertisement_path(@advertisement)
    else
      flash[:notice] = "There were errors"
      render :action => "edit"
    end
  end
  
  def destroy
    @advertisement = Advertisement.find(params[:id])
    @advertisement.destroy
    redirect_to advertisements_path
  end
end
