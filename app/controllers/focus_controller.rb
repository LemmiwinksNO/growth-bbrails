class FocusController < ApplicationController
  respond_to :json

  def index
    @focuses = Focus.all
  end

  def show
    @focus = Focus.find params[:id]
  end

  def create  # Create new focus
    @focus = Focus.new
    if @focus.update_attributes params
      render "focus/show"
    else
      respond_with @focus
    end
  end

  def destroy
    focus = Focus.find params[:id]
    focus.destroy()
    render json: {}  # Backbone needs some response back from the server.
  end

  def update  # PUT /focus/:id
    @focus = Focus.find params[:id]

    if @focus.update_attributes params
      render "focus/show"
    else
      respond_with @focus
    end
  end

end
