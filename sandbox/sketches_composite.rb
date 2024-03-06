require 'pixelart'

## update fam composite via /inscribe images


ids  = [
    3, 5, 7, 9, 10, 11, 13, 14, 
    15, 17, 18, 19, 20
]

cols = 7
rows = ids.size / cols 
rows += 1    if ids.size % cols != 0
fam = ImageComposite.new( cols, rows, height: 57, width: 57 )


ids.each do |id|
    fam << Image.read( "./sketches/inscribe/sketch#{id}.png" )
end

fam.save( "./tmp/sketches_mints.png" )
fam.zoom(2).save( "./tmp/sketches_mints@2x.png" )


puts "bye"