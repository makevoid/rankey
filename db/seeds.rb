DataMapper.auto_migrate!

user = User.create! name: "makevoid", email: "makevoid@gmail.com"

site = Site.create! name: "makevoid.com"

key = site.keys.create! name: "makevoid"
key = site.keys.create! name: "ruby on rails firenze"

key.positions.create! pos: 1, engine: Google
key.positions.create! pos: 2, engine: Yahoo
key.positions.create! pos: 5, engine: Bing