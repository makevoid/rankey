class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def login_url
    raise "why?".inspect
    "/login"
  end
  # before_filter :require_login
  before_filter :check_user
  
  def session_valid?(session)
    User.first(session: session)
  end
  
  
  def check_user 
    user_session = session[:user_session]
    user = if user_session
      user = session_valid?(user_session)
      user ? user.attributes : {}
    else
      {}
    end
    @current_user_data = { session: user_session }.merge(user).to_json
  end
  
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  def request_not_json?
    !request.formats.include? "application/json"
  end
  
  def backbone_default_if_html
    render template: "rankey/show", layout: 'application' if request_not_json?
  end
  
  def not_found(thing)
    { error: { type: "not_found", object: thing, message: "#{thing.to_s.capitalize} not found"} }
  end
end