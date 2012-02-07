# RanKey

### keywords ranking checker for SEO (Rails 3.1 + Backbone.js)

scrapes google, yahoo and bing 

### Features:

- scraper with net/http 
- backbone ui
- themable sass

### v2

integrazione api adwords:

- to show on site page (for each keyword)
  - monthly visitors 
  - cpc

- for seo
  - similar keywords suggestion (why?)

### TODO:

add cronjob:       

    DELETE from positions WHERE created_on < (NOW() - INTERVAL 2 WEEK)      


- manage auth & roles

- site page
  - click goes to search engine page
  - keywords filter via search
  - button to filter posizionate (default sui venditori? - mod)
- add theme config 
- deploy & start a worker on another machine (EC2) 
- app or mountable engine?
- rescue queue?
- redis db for keywords positions?

- lighten the gemfile for test and travis

### Engines

- Google
- Yahoo
- Bing

### Roles

- admin
- seo
- client
- viewer




### crontab:

    
    su www-data - -c "cd /www/rankey/current; ruby lib/crawl.rb production google" >> /www/rankey/current/log/crawl.log &
    su www-data - -c "cd /www/rankey/current; ruby lib/crawl.rb production yahoo" >> /www/rankey/current/log/crawl.log &
    su www-data - -c "cd /www/rankey/current; ruby lib/crawl.rb production bing" >> /www/rankey/current/log/crawl.log &
  
    mysql -u root --password=SECRET rankey_production -e "DELETE from positions WHERE created_on < (NOW() - INTERVAL 1 WEEK)"
  




    ### notes to myself

    grepkill some processes:


        pgrep -fl google
        pgrep -fl yahoo
        pgrep -fl bing    

        pgrep -fl google | awk '{print $1}' | xargs kill -9
        pgrep -fl yahoo | awk '{print $1}' | xargs kill -9
        pgrep -fl bing | awk '{print $1}' | xargs kill -9

    insights:

    GET http://www.google.com/insights/search/overviewReport?q=QUERY&content=1


    clienti potenziali:

    - ditte che fanno servizio di seo e sem con tanti siti web 
