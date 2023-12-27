## our own "3rd" party gems
require 'artfactory/base'



## our own code
require_relative 'monkes21/version'    # note: let version always go first



###
## add convenience pre-configurated generatored with build-in spritesheet (see config)
module Monke21
  class Spritesheet
    def self.builtin
      @builtin ||= Pixelart::Spritesheet.read(  "#{Pixelart::Module::Monkes21.root}/config/spritesheet.png",
                                                "#{Pixelart::Module::Monkes21.root}/config/spritesheet.csv",
                                                 width:  28,
                                                 height: 28 )
    end

    def self.builtin_rocks
        @builtin_rocks ||= Pixelart::Spritesheet.read(  "#{Pixelart::Module::Monkes21.root}/config/spritesheet_rocks.png",
                                                  "#{Pixelart::Module::Monkes21.root}/config/spritesheet_rocks.csv",
                                                   width:  28,
                                                   height: 28 )
    end  
  end  # class Spritesheet
  ## add convenience (alternate spelling) alias - why? why not?
  SpriteSheet = Spritesheet
  Sheet       = Spritesheet
  Sprite      = Spritesheet


  class Image < Pixelart::Image
    def self.generator
      @generator ||= Artfactory.use(  Monke21::Sheet.builtin,
                                      image_class: Image )
    end

    def self.generator_rocks
      @generator_rocks ||= Artfactory.use(  Monke21::Sheet.builtin_rocks,
                                            image_class: Image )
    end


    NAMES = ['monke21', 'monkes21']

    DEFAULT_ATTRIBUTES = [
        'orange orc', 'hoodie orange', 'lasereyes red'
    ]

    def self.generate( *names )
        if names[0].downcase.index( 'rock' )
            ## remove rock from (base) name
            generator_rocks.generate( names[0].downcase.sub( 'rock', '' ), 
                                      *names[1..-1] )
        else
            generator.generate( *names )
        end
    end
  end # class Image
end #  module Monke21



###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart



puts Pixelart::Module::Monkes21.banner    # say hello
