# encoding: utf-8

######
# note: to run use
#
#    $ ruby ./server.rb


class StarterApp < Sinatra::Base

#####################
# Models

include BeerDb::Models


  ##############################################
  # Controllers / Routing / Request Handlers

get '/' do

  ## self-docu in json
  data = {
    endpoints: {
      get_beer: {
        doc: 'get beer by key',
        url: '/beer/:key'
      },
      get_random_beer: {
        doc: 'get random beer',
        url: '/beer/r|rnd|rand|random'
      },
      get_brewery: {
        doc: 'get brewery by key',
        url: '/brewery/:key'
      },
      get_random_brewery: {
        doc: 'get random brewery',
        url: '/brewery/r|rnd|rand|random'
      }
    }
  }

  json_or_jsonp( data.to_json )
end

  get '/beer/:key' do |key|

    if ['r', 'rnd', 'rand', 'random'].include?( key )
      # special key for random beer
      # Note: use .first (otherwise will get ActiveRelation not Model)
      beer = Beer.rnd.first
    else
      beer = Beer.find_by_key!( key )
    end

    json_or_jsonp( beer.as_json_v2 )
  end


  get '/brewery/:key' do |key|

    if ['r', 'rnd', 'rand', 'random'].include?( key )
      # special key for random brewery
      # Note: use .first (otherwise will get ActiveRelation not Model)
      brewery = Brewery.rnd.first
    else
      brewery = Brewery.find_by_key!( key )
    end

    json_or_jsonp( brewery.as_json_v2 )
  end


### helper for json or jsonp response (depending on callback para)

private
def json_or_jsonp( json )
  callback = params.delete('callback')
  response = ''

  if callback
    content_type :js
    response = "#{callback}(#{json})"
  else
    content_type :json
    response = json
  end

  response
end


end # class StarterApp
