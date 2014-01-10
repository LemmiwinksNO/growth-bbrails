class ProcedureController < ApplicationController
  respond_to :json

  def index
    @procedures = Procedure.all
  end

  def show
    @procedure = Procedure.find params[:id]
  end

  def create  # Create new procedure
    @procedure = Procedure.new
    if @procedure.update_attributes params
      render "procedure/show"
    else
      respond_with @procedure
    end
  end

  def destroy
    procedure = Procedure.find params[:id]
    procedure.destroy()
    render json: {}  # Backbone needs some response back from the server.
  end

  def update  # PUT /procedure/:id
    @procedure = Procedure.find params[:id]

    if @procedure.update_attributes params
      render "procedure/show"
    else
      respond_with @procedure
    end
  end

end
