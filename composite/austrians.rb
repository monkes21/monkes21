require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )
puts "    #{recs.size} record(s)"

monkes =  recs.select { |rec| rec['background'] == 'austria' }
puts "    #{monkes.size} monke record(s)"
#=>  1095 monke record(s) )


composite = ImageComposite.new( 10, 10, 
                                  width: 28+2, height: 28+2 )

                                  
monkes[0,100].each do |monke|
    num =  "%05d" % monke['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    frame = Image.new( 30, 30, 'black' )
    frame.compose!( img, 1, 1 )

    composite << frame
end


composite.save( "./tmp/austrians.png" )
composite.zoom(4).save( "./tmp/austrians@4x.png" )

puts "bye"