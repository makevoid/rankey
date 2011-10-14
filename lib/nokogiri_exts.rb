class Nokogiri::XML::Element
  def inner_link_text
    inner_text.gsub(/https:\/\/www\.|https:\/\/|(\/|\s).*$|^www\./, '')
  end
end