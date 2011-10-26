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



### notes to myself

insights:

GET http://www.google.com/insights/search/overviewReport?q=QUERY&content=1


clienti potenziali:

- ditte che fanno servizio di seo e sem con tanti siti web 




