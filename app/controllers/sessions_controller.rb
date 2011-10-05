class SessionsController < ApplicationController # Auth
  
  before_filter :backbone_default_if_html
  
  layout nil
  
  # TODO: translations 1
  
  def create
    user = login(params[:username], params[:password], params[:remember_me])
    resp = if user
      user.generate_session!
      session[:user_session] = user.session
      { success: { message: "Logged in!" }, token: user.session }
    else
      { error:  { name: "auth_error", message: "Email or password was invalid" } }
    end
    render json: resp
  end
  
  def destroy
    logout
    session[:user_session] = user.session
    render json: { success: { message: "Logged out!" } }
  end
  
end