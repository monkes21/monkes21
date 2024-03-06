###
#  to run use:
#    $ ruby sandbox/sketch.rb


require 'monkes21'



module Pixelart
class Image

def flood_fill!( start_x=0, start_y=0, fill_color: )
    target_color = @img[start_x, start_y]
 
    return if target_color == fill_color   ## avoid endless processing

    queue = []  
    queue << [start_x,start_y]
 
    until queue.empty?
      x, y = queue.pop
      color = @img[x,y]
 
      next if target_color != color

      @img[x,y] = fill_color

      queue << [x, y - 1]   if  y-1 >= 0            # up
      queue << [x, y + 1]   if  y+1 <  @img.height  # down
      queue << [x - 1, y]   if  x-1 >= 0            # left
      queue << [x + 1, y]   if  x+1 <  @img.width   # right
    end  
end
end   # class Image
end  # module Pixelart


  

specs = read_csv( "./monkes21.csv" )
puts "   #{specs.size} record(s)"


specs = parse_csv( <<DATA )
type, accessories
alien, hoodie
alien, hoodie / laser eyes red
alien, hoodie / eyes left
alien, cap mcd red
golden, crown
gold orc, crown
golden, laser eyes red


pepe,
pepe, cap ordinal
pepe, hoodie
pepe block,

safemode, cap ordinal

boned, peak spike

pink small, bob blonde small / shades cool / earring

squiggle, laser eyes red
squiggle, eyes left

punk, peakspike / lasereyes-punk

rock alien, headband
rock alien, crown
rock alien, cap mcd red
rock golden block, 3d glasses



DATA


## note: 57px = 28px*2+1 
composite = ImageComposite.new( 7, 3, width: 57, height: 57 )

BITCOIN_ORANGE = Color.parse( '#FD5401' )

specs.each_with_index do |rec, i|
    base        = rec['type']
    accessories = (rec['accessories'] || '' ).split( '/').map { |acc| acc.strip }
    
    ## note: skip background
    spec = [base] + accessories

    img = Monke21::Image.generate( *spec ).sketch( 1, line: 1)
    
    img.flood_fill!( 0, 0, fill_color: BITCOIN_ORANGE )  
    img.flood_fill!( img.width-1, img.height-1, fill_color: BITCOIN_ORANGE )  

    puts "==> monke sketch #{i}"
    img.save( "./tmp/sketch21/sketch#{i}.png" )
    img.zoom(8).save( "./tmp/sketch21/i@8x/sketch#{i}@8x.png" )
    
    composite << img  
end

composite.save( "./tmp/sketch21/sketches21.png" )
composite.zoom(2).save( "./tmp/sketch21/sketches21@2x.png" )


puts "bye"