class NotdoController < ApplicationController
  respond_to :json

  # GET /notdo
  def index # get all
    @notdo = Notdo.all
    # render "notdo/index"  # Happens by default
  end

  # GET /notdo/:id
  def show  # get item
    @item = Notdo.find params[:id]
    # render "notdo/show"  # Happens by default
  end

  # POST /notdo
  def create  # Create new notdo item
    @item = Notdo.new
    if @item.update_attributes params
      render "notdo/show"
    else
      respond_with @item
    end
  end

  # DELETE /notdo/:id
  def destroy  # Delete notdo item
    item = Notdo.find params[:id]
    item.destroy()
    render json: {}  # Backbone needs some response back from the server.
  end

  # PUT /notdo/:id
  def update
    @item = Notdo.find params[:id]

    if @item.update_attributes params
      render "notdo/show"
    else
      respond_with @item
    end
  end

end
