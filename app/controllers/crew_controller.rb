class CrewController < ApplicationController
  respond_to :json

  def index
    @crew = Crew.all
  end

  def show
    @member = Crew.find params[:id]
  end

  def update
    sleep 1
    @member = Crew.find params[:id]
    # If we can successfully update the model, respond with most up to date
    # attributes.
    if @member.update_attributes params
      render "crew/show"
    # Otherwise, respond the model - which includes validation errors.
    else
      respond_with @member
    end
  end

  # Create new crew member. If we can update it (no validation errors), render
  # show json. Otherwise, resond with the member object which has the errors.
  def create
    @member = Crew.new
    if @member.update_attributes params
      render "crew/show"
    else
      respond_with @member
    end
  end

  def destroy
    sleep 1
    member = Crew.find params[:id]
    member.destroy()
    render json: {}  # Backbone needs some response back from the server
  end
end