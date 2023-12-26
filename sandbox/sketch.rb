require 'pixelart'

require_relative 'base'


specs = read_csv( "./monkes21.csv" )
puts "   #{specs.size} record(s)"



composite = ImageComposite.new( 10, 10, width: 57, height: 57 )

specs[0,100].each_with_index do |rec, i|
    base        = rec['type']
    accessories = (rec['accessories'] || '' ).split( '/').map { |acc| acc.strip }
    background  = rec['background']
    
    ## note: skip background
    spec = [base] + accessories

    img = generate( *spec ).sketch( 1, line: 1)
     
    num = "%05d" % i
    puts "==> monke #{num}"
    img.save( "./tmp/sketch/monke#{num}.png" )
    img.zoom(8).save( "./tmp/sketch/i@4x/monke#{num}@4x.png" )
    
    composite << img
end

composite.save( "./tmp/sketches.png" )



puts "bye"