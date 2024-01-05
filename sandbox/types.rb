###
#  to run use:
#    $ ruby sandbox/sketch.rb


require 'monkes21'


specs = parse_data( <<DATA )
  rock golden block
   rock gray block
   rock albino
   rock dark
   rock gray
   rock golden
   rock deathbot
   rock alien
   rock pepe
   rock memepool
   rock green
   rock safemode
   rock pink
   rock zombie
   rock demon
   rock default
   rock black
   rock maxibiz
   rock brown
   maxibiz6
   maxibiz4
   punk
   maxibiz5
   squiggle
   maxibiz3
   maxibiz2
   maxibiz
   orange2
   orange
   pepe block
   light small
   dark small
   albino small
   medium small
   orange2 orc
   orange orc
   blue
   greener
   gold
   gray
   red
   purple small
   green small
   green
   white
   purple
   gray small
   gold orc
   greener orc
   blue orc
   pepe
   rainbow
   hyena
   golden
   demon
   deathbot
   bot
   boned
   alien
   default
   safemode
   mempool
   black
   zombie
   brown
   pink small
DATA
puts "   #{specs.size} record(s)"
#=>  66 record(s)



composite = ImageComposite.new( 11, 6, width: 28, height: 28 )

specs.each_with_index do |rec, i|
    name        = rec[0]
    key         = name.gsub( ' ', '_' )
    
    img = Monke21::Image.generate( name )

    img.save( "./tmp3/#{key}.png" )
    img.zoom(2).save( "./tmp3/@2x/#{key}@2x.png" )
    img.zoom(10).save( "./tmp3/@10x/#{key}@10x.png" )
    
    composite << img  
end

composite.save( "./tmp/types.png" )
composite.zoom(2).save( "./tmp/types@2x.png" )



puts "bye"

