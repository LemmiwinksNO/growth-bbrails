class TicketController < ApplicationController
  respond_to :json

  # GET /ticket
  def index # get all
    @tickets = Ticket.all
    # NOTE: @tickets rather than tickets. Items attached to this are available to the view.
    # render "ticket/index"  # Happens by default
  end

  # GET /ticket/:id
  def show  # get ticket
    @ticket = Ticket.find params[:id]
    # render "ticket/show"  # Happens by default
  end

  # POST /ticket
  def create  # Create new ticket ticket
    @ticket = Ticket.new
    if @ticket.update_attributes params
      render "ticket/show"
    else
      respond_with @ticket
    end
  end

  # DELETE /ticket/:id
  def destroy  # Delete ticket
    ticket = Ticket.find params[:id]
    ticket.destroy()
    render json: {}  # Backbone needs some response back from the server.
  end

  # PUT /ticket/:id
  def update
    @ticket = Ticket.find params[:id]

    if @ticket.update_attributes params
      render "ticket/show"
    else
      respond_with @ticket
    end
  end

end
