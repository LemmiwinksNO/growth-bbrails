class NotdoController < ApplicationController
  respond_to :json

  def index # get all
    @notdo = Notdo.all
    # render "notdo/index"  # Happens by default
  end

  def show  # get item
    @item = Notdo.find params[:id]
    # render "notdo/show"  # Happens by default
  end

  # Create new notdo item
  def create
    @item = Notdo.new
    if @item.update_attributes params
      render "notdo/show"
    else
      respond_with @item
    end
  end

end
