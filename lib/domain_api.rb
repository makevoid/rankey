module DomainAPI
  require 'net/http'
  # HTTPS not supported yet
  #require 'net/https'
  
  class ServiceException < StandardError; end  
  class BadRequestException < ServiceException; end
  class NotAuthorizedException < ServiceException; end
  class NotFoundException < ServiceException; end
  class InternalServerErrorException < ServiceException; end
  class ServiceUnavailableException < ServiceException; end  
  class WrongParmatersException < ServiceException; end
  class NoDomainException < ServiceException; end
  class UnknownException < ServiceException; end
  
  # Defaut HOST for the request
  HOST    = "api.domainapi.com"
  # Default PORT for the request
  PORT    = "80"
  # Default VERSION for the request
  VERSION = "v1"
  # Default FORMAT for the request
  FORMAT  = "json"

  # Authentication of the user
  def self.use(username,password=false)
    if username.kind_of? Hash
       @username,@password = username[:username],username[:password]
    else
      @username, @password = username, password
    end
    self
  end
  
  # Select which service must be called for this request
  def self.get(service)    
    @service = service
    self
  end
  
  # change the format of the response (only XML or JSON)
  def self.as(format)     
    @format = format
    self
  end
  
  # to specify options to the service
  def self.where(options)    
    @options = options
    @options = self.vars_hash_to_string(@options) if @options.kind_of? Hash
    self
  end
  
  # to overide settings, only for specific cases or for testing
  def self.with(settings={})
    @host     = settings[:host] ? settings[:host] : HOST
    @port     = settings[:port] ? settings[:port] : PORT
    @version  = settings[:version] ? settings[:version] : VERSION
    self
  end
  
  # Param of the request, usually a domain name or sometime the first part of a domain
  def self.on(domain,execute=true)
    @domain = domain
    return self.do if execute
    self
  end
  
  # Alias to make a request with only one hash
  def self.execute(params={})
    self.prepare(params)    
    self.on     params[:on] if params[:on]    
  end
  
  # used to set data but don't start the request
  def self.prepare(params={})
    raise DomainAPI::WrongParmatersException unless params.kind_of? Hash
    self.use    params[:auth] if params[:auth] 
    self.get    params[:service] if params[:service]
    self.as     params[:format] if params[:format] 
    self.where  params[:options] if params[:options] 
    self.with   params[:with] if params[:with]
    self.on(params[:on],false) if params[:on]
    self
  end
  
  # check first, raise exception if needed, execute the HTTP request
  def self.do
    self.validate
    self.build_url
    self.do_request
  end
  
  private
  
  # convert a Hash into inline string for GET params
  def self.vars_hash_to_string(hash)    
    vars = Array.new
    hash.each {|key, value| vars.push key.to_s+"="+value.to_s}
    vars.join('&')
  end
  
  # build service url
  def self.build_url
    @url    = "/"+@version+"/"+@service+"/"+@format+"/"+@domain
    @url    += "?"+@options if @options
  end
  
  def self.validate
    raise DomainAPI::NoDomainException unless @domain
    #must be a valid format (will be default TYPE constant if empty or wrong)
    @format = FORMAT if @format!="json" && @format!="xml"
    #if not set with "with" function, use default
    @host     = HOST if !@host
    @port     = PORT if !@port
    @version  = VERSION if !@version
  end
  
  # Connect to the server and execute the request
  def self.do_request
    begin
      @debug = @url
      Net::HTTP.start(@host) do |http|
        req = Net::HTTP::Get.new(@url)
        # HTTP Basic Auth for the user
        req.basic_auth @username, @password
        # Requesting
        @response = http.request(req)
        # Check for errors        
        self.check_request_status       
        return @response.body
      end
    rescue Exception => e
      # Can be usefull to rescue specific NET::HTTP exceptions here
      raise e
    end
  end
  
  # Check HTTP request status and raise an exception if needed
  def self.check_request_status    
    case @response.code.to_i
      when 200
        return true 
      when 400 
        raise DomainAPI::BadRequestException
      when 401 
        raise DomainAPI::NotAuthorizedException      
      when 404 
        raise DomainAPI::NotFoundException
      when 500 
        raise DomainAPI::InternalServerErrorException
      when 503 
        raise DomainAPI::ServiceUnavailableException
      else 
        raise DomainAPI::UnknownException
    end
  end
  
end