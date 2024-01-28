require 'pixelart'


recs = read_csv( "../monkesee-monkedo/monkesee-monkedo.csv" )

monkes =  recs.select do |rec| 
                 rec['type'] == 'mempool' && rec['id'].to_i(10) < 20000 
               end
puts "    #{monkes.size} / #{recs.size} record(s)"
#=>  769 / 21000  record(s)


monkes = monkes[0,100]  ## limt to first hundred

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


composite.save( "./tmp/mempools.png" )
composite.zoom(4).save( "./tmp/mempools@4x.png" )

puts "bye"
