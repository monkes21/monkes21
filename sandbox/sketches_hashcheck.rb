###
#  to run use:
#    $ ruby sandbox/sketches_hashcheck.rb


$LOAD_PATH.unshift( "../../ordbase/ordbase/ordinals/lib" )
require 'ordinals'


missing = []


ids = (0..20).to_a
ids.each do |id|
    path = "./sketches/hashcheck/#{id}.json"

    if File.exist?( path )
        ## skip; already checked
    else
        ## note: start counting at 0/0
      puts "==> #{id+1}/#{ids.size}..."
      blob = read_blob( "./sketches/inscribe/sketch#{id}.png" )
      hash = Digest::SHA256.hexdigest( blob )

      data = Ordinalsbot.hashcheck( hash )

      puts "  #{data['status']} #{data['count']}"

      if data['status'] != 'ok'
        puts "!! ERROR - expected status ok, got:"
        pp data
        exit 1
      end

           ## note: only write-out - if count greater one!!!
      if data['count'] > 0
           write_json( path, data )    
      else
           missing << id
      end
    end
end


puts "  #{missing.size} missing item(s) found:"
pp missing


puts "bye"