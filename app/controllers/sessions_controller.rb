class SessionsController < ApplicationController # Auth
  
  layout nil
  
  # TODO: translations 1
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    resp = if user
      { success: { message: "Logged in!" } }
    else
      { error:  { name: "auth_error", message: "Email or password was invalid" } }
    end
    render json: resp
  end
  
  def destroy
    logout
    render json: { success: { message: "Logged out!" } }
  end
  
end