require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )
puts "    #{recs.size} record(s)"

monkes =  recs.select { |rec| rec['background'] == 'dollar pattern' && 
                              rec['type'] == 'greener orc' }
puts "    #{monkes.size} monke record(s)"
#=>  500+ monke record(s) )


composite = ImageComposite.new( 10, 10, 
                                  width: 28, height: 28 )

                                  
monkes[0,100].each do |monke|
    num =  "%05d" % monke['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    composite << img
end


composite.save( "./tmp/greenerorcs.png" )
composite.zoom(4).save( "./tmp/greenerorcs@4x.png" )

puts "bye"