class Admin::TastesController < ApplicationController

  def index
    @taste = Taste.new
    @tastes = Taste.all
  end
  
  def create
    @taste = Taste.new(taste_params)
    @taste.save
    redirect_to admin_tastes_path
  end
  
  def edit
    @taste = Taste.find(params[:id])
  end
  
  def update
    taste = Taste.find(params[:id])
    taste.update(taste_params)
    redirect_to admin_tastes_path
  end
  
  private
  
   def taste_params
     params.require(:taste).permit(:name)
   end
   
end
