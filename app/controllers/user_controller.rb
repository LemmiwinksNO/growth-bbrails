class UserController < ApplicationController
  respond_to :json

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def create
  end

  def destroy
  end

  def update
  end

end