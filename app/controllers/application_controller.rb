class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # json session
  
  def user
    # puts "-"*80
    # puts "SESSION: #{session[:user_session]}"
    @user ||= @current_user || User.first(session: session[:user_session])
  end  

  def login_required
    return invalid_session if user.nil?
  end
  
  def invalid_session
    render json: { error: "session not valid" }, status: :error
  end
  
  
  # 
  
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
    # puts "-"*90
    # puts user_session
    user = if user_session
      curr_user = session_valid?(user_session)
      curr_user ? curr_user.public_attributes : {}
    else
      {}
    end
    @current_user = curr_user
    @current_user_data = { session: user_session }.merge(user).to_json
  end
  
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to access this page."
  end
  
  def request_not_json?
    !request.formats.include? "application/json"
  end
  
  def request_html?
    # puts request.formats.inspect
    # puts request.formats.include? "text/html"
    request.formats.include? "text/html"
  end
  
  def backbone_default_if_html
    render template: "rankey/show", layout: 'application' if request_not_json?
  end
  
  # errors
  
  def not_found(thing)
    { error: { type: "not_found", object: thing, message: "#{thing.to_s.capitalize} not found"} }
  end
  
  def model_error(mode, thing)
    { error: { type: "model error", object: thing, mode: mode, message: "error #{mode[0..-2]}ing the model of class #{thing.class.name}"} }
  end
end