###
#  to run use
#     ruby -I ./lib sandbox/test_generate.rb


require 'monkes21'


monke = Monke21::Image.generate( 'orange orc', 'hoodie orange', 'lasereyes red' )
monke.save( "tmp/monke1.png")
monke.zoom(4).save( "tmp/monke1@4x.png" )

monke = Monke21::Image.generate( 'demon', 'tophat midnight', 'shades cool' )
monke.save( "tmp/monke2.png")
monke.zoom(4).save( "tmp/monke2@4x.png" )

monke = Monke21::Image.generate( 'squiggle', 'eyes left' )
monke.save( "tmp/monke3.png")
monke.zoom(4).save( "tmp/monke3@4x.png" )


monke = Monke21::Image.generate( 'rock gray block', 'eyes green' )
monke.save( "tmp/monke4.png")
monke.zoom(4).save( "tmp/monke4@4x.png" )


monke = Monke21::Image.generate( 'rock green', 'wildhair', 'eyes polarized' )
monke.save( "tmp/monke5.png")
monke.zoom(4).save( "tmp/monke5@4x.png" )

monke = Monke21::Image.generate( 'rock pepe', 'mohawk red' )
monke.save( "tmp/monke6.png")
monke.zoom(4).save( "tmp/monke6@4x.png" )

monke = Monke21::Image.generate( 'rock alien', 'knittedcap' )
monke.save( "tmp/monke7.png")
monke.zoom(4).save( "tmp/monke7@4x.png" )


puts "bye"
