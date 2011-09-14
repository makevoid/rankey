module CustomHelpers
  
  def json_get(url)
    get url
    parse_json response
  end
  
  def json_post(url, params={})
    post url, params
    parse_json response
  end
  
  def json_delete(url, params={})
    delete url, params
    parse_json response    
  end
  
  # private
  
  def parse_json(response)
    json = JSON.parse response.body
    json.symbolize_keys! if json.is_a? Hash
    json
  end
  
end

include CustomHelpers