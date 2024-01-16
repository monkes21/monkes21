###
#  to run use:
#    $ ruby sandbox/editions.rb


require 'cocos'


## note: duplicates/triplicates have same hashcheck datafile


stats = Hash.new( 0 )

hashes = {}

## note: MUST start at 0!!!!
#  items = items[0,10000]    ## cut-off - first 100, etc.
(0..20999).each do |i|
    num = '%05d' % i
    path = "./hashcheck/#{num}.json"


    if !File.exist?( path )
      puts "!! hashcheck datafile missing"
      exit 1
    end

    print "."

    data = read_json( path )

    ## get hash from first result
    hash  = data['results'][0]['contenthash'] 
    count = data['results'].size 
    
    ## skip duplicates for now
    next if hashes.has_key?( hash )
    
    hashes[ hash ] = count

    stats[ count ] += 1

    print count   if count > 1
end


puts "edition stats:"
pp stats


puts "bye"