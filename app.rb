# encoding: utf-8

######
# note: to run use
#
#    $ ruby ./server.rb


class StarterApp < Webservice::Base

  #####################
  # Models

  include BeerDb::Models


  ##############################################
  # Controllers / Routing / Request Handlers


  ## add self-docu in json
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
  end


  # try special (reserved) keys for random beer first
  get '/beer/(r|rnd|rand|random)' do
    Beer.rnd
  end

  get '/beer/:key' do
    Beer.find_by! key: params[ 'key' ]
  end


  # try special (reserved) keys for random brewery first
  get '/brewery/(r|rnd|rand|random)' do
    Brewery.rnd
  end

  get '/brewery/:key' do
    Brewery.find_by! key: params[ 'key' ]
  end

end # class StarterApp
