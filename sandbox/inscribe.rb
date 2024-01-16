require 'cocos'


## add first 20000 minkesee, monkedos                                  
(0..19999).each do |i|
    print "."
    num =  "%05d" % i
    blob = read_blob( "../monkesee-monkedo/i/monke#{num}.png" )
    write_blob( "./inscribe/monke#{num}.png", blob )
end

## add let's rock
(0..999).each do |i|
    print "."
    num =  "%03d" % i
    blob = read_blob( "../letsrock/i/rock#{num}.png" )

    num = "%05d" % (i+20000)
    write_blob( "./inscribe/monke#{num}.png", blob )
end

puts "bye"
