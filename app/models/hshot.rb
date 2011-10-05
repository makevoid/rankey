class SiteNotFound < Exception
  def initialize(site)
    @site = site
  end
  
  def message
    "error in finding the site, got: #{@site} - review your list of sites, or the site you are calling"
  end
end

class HShot

  SIZE = '500x350' # screenshot size
  
  require 'url2png'
  require 'net/http'

  include Url2png::Helpers::Common
  
  def get(site)
    site if valid?(site)
    raise SiteNotFound.new(site) if site.nil?
    get_url site
  end
  
  private
  
  def valid?(site)
    site =~ URI::regexp
  end
  
  def async(&block)
    t = Thread.new{
      block.call
    }
    t.abort_on_exception
  end
  
  def get_url(url)
    Url2png::Config.public_key = 'P4E548D4E3A596'
    Url2png::Config.shared_secret = File.read("#{ENV["HOME"]}/.url2png").strip
    
    # async do
    #   prefetch_image url
    # end

    site_image_url url, :size => SIZE
  end
  
  def prefetch_image(url)
    uri = URI.parse url
    Net::HTTP.get_response uri
    # TODO: consider get_head
  end
end