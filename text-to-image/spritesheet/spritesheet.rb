####################
#  assemble spritesheet (all-in-one composite image with attributes)
#  to run use:
#    $ ruby spritesheet.rb



require 'pixelart'


ATTRIBUTES = {
   base: [
     'albino-small',
     'brown',
     'dark-small',
     'gray-small',
     'gray',
     'green-small',
     'green',
     'light-small',
     'medium-small',
     'pink-small',
     'pink',
     'purple-small',
     'purple',
     'red',
     'white',
   ## classic specials
       'alien',
       'boned',
       'bot',
       'deathbot',
       'demon',
       'golden',
       'hyena',
       'mempool',
       'pepe-block',
       'pepe',
       'rainbow',
       'safemode',
       'zombie',
   ## more
         'blue-orc',
         'blue',
         'gold-orc',
         'gold',
         'greener-orc',
         'greener',
         'orange-orc',
         'orange',
         'orange2-orc',
         'orange2',
         'punk',
         'squiggle',
         'black',
         'default',
     ],
   'eyes': [
      '3dglasses',
      'shades-blend',
      'shades-rainbow',
      'eyepatch',
      'eyes-big',
      'eyes-big-blue',
      'eyes-bored',
      'eyes-bot',
      'eyes-bot-green',
      'eyes-deathbot',
      'eyes-left',
      'eyes-monobrow',
      'eyes-pepe',
      'eyes-right',
      'eyes-zombie',
      ## more
         'eyemask',
         'eyes-blue',
         'eyes-blue-small',
         'eyes-blue-big',
         'eyes-alien',
         'eyes-demon',
         'lasereyes-red',
         'lasereyes-blue',
         'lasereyes-green',
         'lasereyes-gold',
         'lasereyes-punk',
         'vr',
         'shades-polarized',
         'shades-cool',
   ],
   'accessories': [
      'bandana',
      'bandana2',
      'bowler',
      'cap-army',
      'cap-mcb',
      'cap-ordinal',
      'cap-safemode',
      'cap-terminal',
      'cap-terminal2',
      'cap-captain',
      'cap',
      'cowboyhat',
      'crown',
      'earring',
      'earring-cross',
      'fez',
      'flathat',
      'frenchcap',
      'halo',
      'knittedcap',
      'knittedcap2',
      'policecap',
      'wizardhat',  
      ## more
         'bubblegum',
         'beanie',
         'cap-burgerking',
         'cap-mcd-black',
         'cap-mcd-red',
         'cap-mcd-white',
         'cap-subway',
         'jesterhat',   
         'helmet',  
         'helmet2',  
         'tophat',
         'tophat-midnight',
         'wizardhat-blue',
         'wizardhat-orange',
         'wizardhat-red',
         'wizardhat-dark',
         'wizardhat-gray',
         'wizardhat-midnight',
         'wizardhat-gold',
         'wizardhat-green',
         'wizardhat-white',
         'headband',       
      ## hoodies
      'hoodie',
      'hoodie-midnight',
      'hoodie-indigo',
      'hoodie-blue',
      'hoodie-cobalt',
      'hoodie-aqua',
      'hoodie-green',
      'hoodie-greener',
      'hoodie-limegreen',
      'hoodie-gold',
      'hoodie-orange',
      'hoodie-ruby',
      'hoodie-red',
      'hoodie-purple',
      'hoodie-pink',
   ], 
   hair: [
       'bob',
       'bob-small',
       'bob-blonde-small',
       'bob-red-small',
       'mohawk',
       'mohawk-blonde',
       'mohawk-green',
       'mohawk-purple',
       'mohawk-red',
       'mohawk2',
       'mohawk2-blonde',
       'mohawk2-green',
       'mohawk2-purple',
       'mohawk2-red',
       'mohawk2-orange',
       'mohawk2-pink',
       'peakspike',
       'peakspike-purple',
       'peakspike-red',
       'peakspike-blonde',
   ],
  maxibiz: [
   'maxibiz',
   'maxibiz2',
   'maxibiz3',
   'maxibiz4',
   'maxibiz5',
   'maxibiz6',
   'maxibiz-punk',
   'maxibiz-punk2',
 
   '3dglasses-1bit',
   'bandana-1bit',
   'bubblegum-1bit',
   'cap-mcb-1bit',
   'cap-ordinal-1bit',
   'cap-terminal-1bit',
   'cowboyhat-1bit',
   'eyes-1bit',
   'flathat-1bit',
   'knittedcap-1bit',
   'maxibiz-lasereyes-blue',
   'maxibiz-lasereyes-green',
   'maxibiz-lasereyes-red',
   'maxibiz-lasereyes2-blue',
   'maxibiz-lasereyes2-green',
   'maxibiz-lasereyes2-red',
  ],
}.reduce( [] ) do |recs,(category, names)| 
     names.each do |name|
        ## fix-up file path by category
        path =  category == :base ? name : "#{category}/#{name}"

        img = Image.read( "../../../monkesee-monkedo/attributes/#{path}.png" )
        recs << [name, category, img] 
     end
     recs
end


ATTRIBUTES_ROCKS = {
   base: [
   'maxibiz',
   'black',
   'default',
   'albino',
   'brown',
   'dark',
   'demon',
   'golden',
   'golden-block',
   'gray',
   'gray-block',
   'green',
   'memepool',
   'pepe',
   'alien',
   'deathbot',
   'safemode',
   'pink',
   'zombie',
  ],
   eyes: [
  '3dglasses',
  'eyes-alien',
  'eyes-big',
  'eyes-blend',
  'eyes-blue',
  'eyes-bored',
  'eyes-cool',
  'eyes-demon',
  'eyes-green',
  'eyes-left',
  'eyes-monobrow',
  'eyes-pepe',
  'eyes-polarized',
  'eyes-rainbow',
  'eyes-red',
  'eyes-zombie',
  'lasereyes-blue',
  'lasereyes-gold',
  'lasereyes-green',
  'lasereyes-red',
  'vr',
  'eyes-left-blue',
  'eyes-big-blue',
  'maxibiz-lasereyes-red',
  'maxibiz-lasereyes-green',
  'maxibiz-lasereyes-blue',
   ],
   accessories: [
  'bandana',
  'bandana2',
  'cowboyhat',
  'headband',
  'knittedcap',
  'knittedcap2',
  'tophat',
  'cap',
  'cap-mcb',
  'cap-mcd-red',
  'cap-mcd-white',
  'cap-mcd-black',
  'cap-burgerking',
  'cap-subway',
  'crown',
  'halo',
   ],
   hair: [
      'mohawk',
      'mohawk-blonde',
      'mohawk-purple',
      'mohawk-red',
      'mohawk2',
      'mohawk2-green',
      'mohawk2-pink',
      'mohawk2-red',
      'peakspike',
      'peakspike-blonde',
      'peakspike-purple',
      'peakspike-red',
      'wildhair',
      'wildhair-blonde',
      'wildhair-red',
      'wildhair-white',
      'bob-blonde',
   ],
}.reduce( [] ) do |recs,(category, names)| 
    names.each do |name|
       ## fix-up file path by category
       path =  category == :base ? name : "#{category}/#{name}"

       img = Image.read( "../../../letsrock/attributes/#{path}.png" )
       recs << [name, category, img] 
    end
    recs
end




def make_composite( attributes )
  puts "   #{attributes.size} attribute(s)"

  cols = 10 
  rows = attributes.size / cols 
  rows += 1    if attributes.size % cols != 0

  composite = ImageComposite.new( cols, rows, 
                                         width: 28, height: 28 )

  attributes.each_with_index do |(name, category, img),i|
    composite << img
  end
  composite 
end


def write_attributes( path, attributes )
   puts "   #{attributes.size} attribute(s)"
   buf = ''
   headers = ['id', 'category', 'name', 'more_names']
   buf << headers.join( ', ' )
   buf << "\n"
   attributes.each_with_index do |(name, category, _),i|
       values = [i.to_s, 
                 category.to_s, 
                name.downcase.gsub( '-', ' ' ),
                '']
       buf << values.join( ', ' )
       buf << "\n"
   end
   write_text( path, buf )
end




composite = make_composite( ATTRIBUTES )
composite.save( "./tmp/spritesheet.png" )
composite.zoom(2).save( "./tmp/spritesheet@2x.png" )

write_attributes( "./tmp/spritesheet.csv", ATTRIBUTES )

composite = make_composite( ATTRIBUTES_ROCKS )
composite.save( "./tmp/spritesheet_rocks.png" )
composite.zoom(2).save( "./tmp/spritesheet_rocks@2x.png" )

write_attributes( "./tmp/spritesheet_rocks.csv", ATTRIBUTES_ROCKS )



puts "bye"

