class ApplicationController < ActionController::Base
  protect_from_forgery
  
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