require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )

monkes =  recs.select { |rec| rec['type'] == 'squiggle' }
puts "    #{monkes.size} / #{recs.size} record(s)"
#=>  102 / 21000  record(s)


cols = 10
rows = monkes.size / cols 
rows += 1    if monkes.size % cols != 0

composite = ImageComposite.new( cols, rows, 
                                  width: 28, height: 28 )

monkes.each do |monke|
    num =  "%05d" % monke['id'].to_i(10)
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    composite << img
end


composite.save( "./tmp/squiggles.png" )
composite.zoom(4).save( "./tmp/squiggles@4x.png" )

puts "bye"
