require 'pixelart'


cols = 200
rows = 21000 / cols 
rows += 1    if 21000 % cols != 0

composite = ImageComposite.new( cols, rows, 
                                  width: 28, height: 28 )

 
## add first 20000 minkesee, monkedos                                  
(0..19999).each do |i|
    num =  "%05d" % i
    img = Image.read( "../monkesee-monkedo/i/monke#{num}.png" )

    composite << img
end

## add let's rock
(0..999).each do |i|
    num =  "%03d" % i
    img = Image.read( "../letsrock/i/rock#{num}.png" )

    composite << img
end


composite.save( "./monkes21.png" )

puts "bye"
