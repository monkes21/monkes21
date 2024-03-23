require 'cocos'
require 'digest'




items = []

ids = (0..20)

count = 0

ids.each do |id|
   puts "==> #{id}"


   blob = read_blob( "./goldcoins/inscribe/goldcoin#{id}.png" )
   hash = Digest::SHA256.hexdigest( blob )
 
   puts hash

   path = "./goldcoins/hashcheck/#{id}.json"
   inscriptionNumber =  if File.exist?( path )
                            count += 1
                            meta = read_json("./goldcoins/hashcheck/#{id}.json" )
                            meta['results'][0]['inscriptionnumber'].to_i(10)
                        else
                            1   ## note: unminted set to 1
                        end
  
   items << { id: hash,
              name: "##{id}",
              image: "https://github.com/orc721/monkes21/raw/master/goldcoins/inscribe/goldcoin#{id}.png",
              inscriptionNumber: inscriptionNumber
            }
end


write_json( "./docs/items.js", items )

## hack to add const items = upfront
buf  = "// items.js generated on #{Time.now.utc}\n"
buf += "//   - mint count at #{count}\n" 
buf += "\n"

buf += " const mintCount = #{count};\n"
buf += " const items = " + read_text( "./docs/items.js" ).rstrip + ";\n"
write_text( "./docs/items.js", buf )

puts "bye"

