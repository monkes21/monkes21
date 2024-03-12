require 'pixelart'

## update fam composite via /inscribe images


ids  = [
    1, 3, 4, 5, 6, 8, 9, 
    11, 12, 14, 15, 16, 17, 18, 
    19, 20
]

cols = 7
rows = ids.size / cols 
rows += 1    if ids.size % cols != 0
fam = ImageComposite.new( cols, rows, height: 12, width: 12 )


ids.each do |id|
    fam << Image.read( "./minis/inscribe/mini#{id}.png" )
end

fam.save( "./tmp/minis_mints.png" )
fam.zoom(8).save( "./tmp/minis_mints@8x.png" )


puts "bye"