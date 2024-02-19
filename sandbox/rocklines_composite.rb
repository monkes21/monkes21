require 'pixelart'

## update fam composite via /inscribe images


ids  = [
    7, 9, 10, 11, 17
]

cols = 5
rows = ids.size / cols 
rows += 1    if ids.size % cols != 0
fam = ImageComposite.new( cols, rows, height: 28, width: 28 )


ids.each do |id|
    fam << Image.read( "./rocklines/inscribe/rockline#{id}.png" )
end

fam.save( "./tmp/rocklines_mints.png" )
fam.zoom(4).save( "./tmp/rocklines_mints@4x.png" )


puts "bye"