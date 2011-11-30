class SessionsController < ApplicationController # Auth
  
  before_filter :backbone_default_if_html
  
  layout nil
    
  def create
    user = login(params[:username], params[:password], params[:remember_me])
    resp = if user
      user.generate_session!
      session[:user_session] = user.session
      { success: { message: "Logged in!" }, session: user.session, name: user.name, email: user.email }
    else
      { error:  { name: "auth_error", message: "Email or password was invalid" } }
    end
    render json: resp
  end
  
  def destroy
    session[:user_session] = nil
    render json: { success: { message: "Logged out!" } }
  end
  
end