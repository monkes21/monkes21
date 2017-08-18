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


  ## self-docu in json
  get '/' do

    data = {
      endpoints: {
        get_beer: {
          doc: 'get beer by key',
          url: '/beer/:key'
        },
        get_random_beer: {
          doc: 'get random beer',
          url: '/beer/(r|rnd|rand|random)'
        },
        get_brewery: {
          doc: 'get brewery by key',
          url: '/brewery/:key'
        },
        get_random_brewery: {
          doc: 'get random brewery',
          url: '/brewery/(r|rnd|rand|random)'
        }
      }
    }

    json_or_jsonp( data )
  end


  # try special (reserved) keys for random beer first
  get %r{/beer/(r|rnd|rand|random)} do
    beer = Beer.rnd
    json_or_jsonp( beer )
  end

  get '/beer/:key' do |key|
    beer = Beer.find_by!( key: key )
    json_or_jsonp( beer )
  end


  # try special (reserved) keys for random brewery first
  get %r{/brewery/(r|rnd|rand|random)} do
    brewery = Brewery.rnd
    json_or_jsonp( brewery )
  end

  get '/brewery/:key' do |key|
    brewery = Brewery.find_by!( key: key )
    json_or_jsonp( brewery )
  end


### helper for json or jsonp response (depending on callback para)

private
def json_or_jsonp( data )

  ## convert data (array, hash, etc. to json)
  ## -- try obj.as_json_v2 first
  if data.respond_to? :as_json_v2
    json = data.as_json_v2
  else
    json = data.to_json
  end

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
