# encoding: utf-8

###
# note: it's an addon to beerdb (get all libs via beerdb)
require 'beerdb'


# our own code

require 'beerdb/service/version' # let it always go first



module BeerDbService

  def self.banner
    "beerdb-service/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname( File.dirname(File.dirname(__FILE__))) )}"
  end

end # module BeerDbService


puts BeerDbService.banner   # say hello

