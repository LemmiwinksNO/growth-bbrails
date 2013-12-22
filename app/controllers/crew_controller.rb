class CrewController < ApplicationController
  respond_to :json

  def index
    @crew = Crew.all
    # render "crew/index"  # Happens by default
  end

  def show
    @member = Crew.find params[:id]
    # render "crew/show"   # Happens by default
  end

  # If we can successfully update the model, respond with most up to date
  # attributes. Otherwise, respond with the model, which includes validation
  # errors.
  def update
    sleep 1
    @member = Crew.find params[:id]

    if @member.update_attributes params
      render "crew/show"
    else
      respond_with @member
    end
  end

  # Create new crew member. If we can update it (no validation errors), render
  # show json. Otherwise, respond with the member object which has the errors.
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