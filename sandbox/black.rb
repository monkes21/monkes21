require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )
puts "    #{recs.size} record(s)"

monkes =  recs.select { |rec| rec['type'] == 'black' }
puts "    #{monkes.size} monke record(s)"
#=>  800+ monke record(s) )


composite = ImageComposite.new( 10, 10, 
                                  width: 28, height: 28 )

                                  
monkes[0,100].each do |monke|
    num =  "%05d" % monke['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    composite << img
end


composite.save( "./tmp/blacks.png" )
composite.zoom(4).save( "./tmp/blackss@4x.png" )

puts "bye"