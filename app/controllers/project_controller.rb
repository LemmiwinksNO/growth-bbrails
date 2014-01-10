class ProjectController < ApplicationController
  respond_to :json

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end

  def create  # Create new project
    @project = Project.new
    if @project.update_attributes params
      render "project/show"
    else
      respond_with @project
    end
  end

  def destroy
    project = Project.find params[:id]
    project.destroy()
    render json: {}  # Backbone needs some response back from the server.
  end

  def update  # PUT /project/:id
    @project = Project.find params[:id]

    if @project.update_attributes params
      render "project/show"
    else
      respond_with @project
    end
  end

end
