require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )
puts "    #{recs.size} record(s)"

punks =  recs.select { |rec| rec['type'] == 'punk' }
puts "    #{punks.size} punk record(s)"
#=>  97 punk record(s)

cols = 10
rows = punks.size / cols 
rows += 1    if punks.size % cols != 0

composite = ImageComposite.new( cols, rows, 
                                  width: 28, height: 28 )

punks.each do |punk|
    num =  "%05d" % punk['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    composite << img
end


composite.save( "./tmp/goldenpunks.png" )
composite.zoom(4).save( "./tmp/goldenpunks@4x.png" )

puts "bye"