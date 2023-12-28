###
#  to run use:
#    $ ruby sandbox/hashcheck.rb


$LOAD_PATH.unshift( "../pixelart/ordbase/ordinals/lib" )
require 'ordinals'


txt = read_text( "./docs/items.js ")
txt = txt.sub( /\A
                 [^\[]+?
                (?=\[)
                   /x, '' )  # strip everying (non-greedy) up to open bracket []

items = JSON.parse( txt )
pp items[0,2]


## note: MUST start at 0!!!!
#  items = items[0,10000]    ## cut-off - first 100, etc.
items.each_with_index do |item,i|
    num = '%05d' % i
    path = "./hashcheck/#{num}.json"

    if File.exist?( path )
        ## skip; already checked
    else
        ## note: start counting at 0/0
      puts "==> #{i}/#{items.size-1} #{item['name']}..."
      hash = item['id']
      data = Ordinalsbot.hashcheck( hash )

      puts "  #{data['status']} #{data['count']}"

      if data['status'] != 'ok'
        puts "!! ERROR - expected status ok, got:"
        pp data
        exit 1
      end

      write_json( path, data )
    end
end



puts "bye"