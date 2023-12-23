###
# double check inscription numbers; to run use:
#
#   $ ruby sandbox/dblcheck.rb



require 'cocos'


monkes21 = read_csv( "../orc721/market/monkes21/mint.csv" )
puts "   #{monkes21.size} monkes21 records"
#=>  20978 monkes21 records

more     = read_csv( "../orc721/market/moremonkes/mint.csv" )
puts "   #{more.size} more records"
#=>  12436 more records 



## build lookup tables by inscribe number
monkes21 = monkes21.reduce( {} ) do |h,rec| 
                                   h[rec['num'].to_i(10)] = rec['ref'].to_i(10)
                                   h 
                                 end

more = more.reduce( {} ) do |h,rec| 
                            h[rec['num'].to_i(10)] = rec['ref'].to_i(10)
                            h 
                         end


## inscriptions - not an image - checked "by hand"
noimage = [49570637]



txt = read_text( "./sandbox/dblcheck.txt" )


NUM_RX = /[0-9]{8,}/

nums =  txt.scan( NUM_RX ).map { |str| str.to_i(10) }.sort.uniq
pp nums


buf = "# Inscribe Number Double Check Report / Log\n\n"


nums.each do |num|
    buf << "- #{num} => "

    if monkes21.has_key?( num )
        buf << "**BINGO!  monkes21 no. #{monkes21[num]}**"
    elsif more.has_key?( num )
        buf << "more monkes match ref no. #{more[num]}"
    elsif noimage.include?( num )
        buf << "!! no match"
    else
        buf << "  ??? not yet indexed; sorry"
    end

    buf << "\n"
end

puts buf

write_text( "./DBLCHECK.md", buf )


puts "bye"






__END__

checked by "hand"

49570637 => ??? not yet indexed; sorry
- is a brc-20 text inscribe ->  https://www.ord.io/49570637


