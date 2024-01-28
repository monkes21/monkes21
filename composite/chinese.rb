require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )

monkes =  recs.select do |rec| 
                         chinese =  rec['background'] == 'china'
                         chinese && 
                         rec['accessories'].index('cap mcd') &&
                         ((rec['type'] == 'golden' ||
                           rec['type'] == 'punk' ))
                      end

puts "    #{monkes.size} / #{recs.size} record(s)"
#=>  6 / 21000  record(s)

pp monkes


cols = 3
rows = monkes.size / cols 
rows += 1    if monkes.size % cols != 0

composite = ImageComposite.new( cols, rows, 
                                  width: 28+2, height: 28+2 )

                                  
monkes.each do |monke|
    num =  "%05d" % monke['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    frame = Image.new( 30, 30, 'black' )
    frame.compose!( img, 1, 1 )

    composite << frame
end


composite.save( "./tmp/goldenchinesemcd.png" )
composite.zoom(4).save( "./tmp/goldenchinesemcd@4x.png" )

puts "bye"