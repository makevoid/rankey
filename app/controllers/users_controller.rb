class UsersController < ApplicationController

  layout nil

  def create
    user = User.new params[:user]
    resp = if user.save
      { success: { message: "Logged in!" } }
    else
      { error:  { name: "auth_error", message: "Email or password was invalid" } }
    end
    render json: resp
  end
 
end