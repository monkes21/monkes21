require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )


## add gold too

monkes =  recs.select do |rec|
                            has_crown = rec['accessories'].index( 'crown') 
                            has_crown && 
                               (rec['type'] == 'golden' ||
                                ## rec['type'] == 'gold' ||
                                rec['type'] == 'gold orc' )
                      end
puts "    #{monkes.size} / #{recs.size} record(s)"
#=>  14 / 21000  record(s)

pp monkes


cols = 4
rows = monkes.size / cols 
rows += 1    if monkes.size % cols != 0

composite = ImageComposite.new( cols, rows, 
                                  width: 28, height: 28 )

monkes.each do |monke|
    num =  "%05d" % monke['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    composite << img
end


composite.save( "./tmp/goldenmonkekings.png" )
composite.zoom(4).save( "./tmp/goldenmonkekings@4x.png" )

puts "bye"
