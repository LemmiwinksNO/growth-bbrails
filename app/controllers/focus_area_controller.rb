class FocusAreaController < ApplicationController
  respond_to :json

  def index
    @focuses = FocusArea.all
  end

  def show
    @focus = FocusArea.find params[:id]
  end

  def create  # Create new focus
    @focus = FocusArea.new
    if @focus.update_attributes params
      render "focus/show"
    else
      respond_with @focus
    end
  end

  def destroy
    focus = FocusArea.find params[:id]
    focus.destroy()
    render json: {}  # Backbone needs some response back from the server.
  end

  def update  # PUT /focus/:id
    @focus = FocusArea.find params[:id]

    if @focus.update_attributes params
      render "focus/show"
    else
      respond_with @focus
    end
  end

end
