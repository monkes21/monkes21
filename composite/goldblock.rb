require 'pixelart'


recs = read_csv( "monkes21.csv" )
puts "    #{recs.size} record(s)"

monkes =  recs.select { |rec| rec['type'] == 'rock golden block' }
puts "    #{monkes.size} monke record(s)"
#=>  10 monke record(s) )


composite = ImageComposite.new( 10, 1, 
                                  width: 28, height: 28 )

                                  
monkes.each do |monke|
    num =  "%03d" % (monke['id'].to_i(10)-20000)
    img = Image.read( "../letsrock/i/rock#{num}.png" )

    composite << img
end


composite.save( "./tmp/goldenblocks.png" )
composite.zoom(4).save( "./tmp/goldenblocks@4x.png" )

puts "bye"
