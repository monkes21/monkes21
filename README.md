# beer.db.starter - Build Your Own HTTP JSON API

The beerdb web service starter sample lets you build your own HTTP JSON API
using the
[`beer.db`](https://github.com/openbeer).  Example:

```ruby
class StarterApp < Sinatra::Base

#####################
# Models

include BeerDb::Models


##############################################
# Controllers / Routing / Request Handlers

get '/beer/:key' do |key|

  if ['r', 'rnd', 'rand', 'random'].include?( key )
    # special key for random beer
    beer = Beer.rnd.first
  else
    beer = Beer.find_by!( key: key )
  end

  json_or_jsonp( beer.as_json_v2 )
end


get '/brewery/:key' do |key|

  if ['r', 'rnd', 'rand', 'random'].include?( key )
    # special key for random brewery
    brewery = Brewery.rnd.first
  else
    brewery = Brewery.find_by!( key: key )
  end

  json_or_jsonp( brewery.as_json_v2 )
end

 ...
end # class StarterApp
```

(Source: [`app.rb`](app.rb))



## Getting Started

Step 1: Install all libraries (Ruby gems) using bundler. Type:

    $ bundle install

Step 2: Copy an SQLite database e.g. `beer.db` into your folder.

Step 3: Startup the web service (HTTP JSON API). Type:

    $ ruby ./server.rb

That's it. Open your web browser and try some services
running on your machine on port 9292 (e.g. `localhost:9292`). 



## License

The `beer.db.starter` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Send them along to the
[Open Beer & Brewery Database Forum/Mailing List](http://groups.google.com/group/beerdb).
Thanks!

