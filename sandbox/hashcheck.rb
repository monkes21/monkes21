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
items = items[0,1000]    ## cut-off - first 100, etc.
items.each_with_index do |item,i|
    num = '%05d' % i
    path = "./hashcheck/#{num}.json"

    if File.exist?( path )
        ## skip; already checked
    else
      puts "==> #{i}/#{items.size} #{item['name']}..."
      hash = item['id']
      data = Ordinalsbot.hashcheck( hash )

      write_json( path, data )
    end
end



puts "bye"