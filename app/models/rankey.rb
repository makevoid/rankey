module Rankey
  # tresholds
  unless defined?(POS_OK)
    POS_OK = 30 # a search key over POS_OK it's considered well positioned
  
    SCRAPE_PAGES = 10 # scrapers will scrape the first SCRAPE_PAGES 
  end
  
end