class UsersController < ApplicationController
  
  before_filter :backbone_default_if_html
  
  layout nil

  def index
    require_login
    { users: User.all.map{ |u| u.attributes } }
  end

  def create
    user = User.new 
    user.username = params[:user][:username]
    user.password = params[:user][:password]
    resp = if user.save
      { success: { message: "Logged in!" } }
    else
      { error:  { name: "auth_error", message: "Email or password was invalid" } }
    end
    render json: resp
  end
 
end