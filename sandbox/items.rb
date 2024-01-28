require 'cocos'
require 'digest'


##
# note: for now MUST add upfront to items.js by hand !!!!!
#    const items = 



## last count is 25 (Dec,14th)

##
## takens
##  
recs = read_csv( "./mint.csv" )
puts "   #{recs.size} taken record(s)"

## look-up table by num
taken = recs.reduce( {} ) do |h,rec|
                               h[rec['ref'].to_i(10)] = rec['num'].to_i(10)
                               h
                          end
pp taken



items = []

nums = (0..19999)
# nums = (0..5)

nums.each do |num|
   puts "==> #{num}"
   name = "%05d" % num
   blob = read_blob( "../monkesee-monkedo/i/monke#{name}.png" )

   hash = Digest::SHA256.hexdigest( blob )
 
   puts hash

   inscriptionNumber = taken[ num ] || 1

   items << { id: hash,
              name: "##{num}",
              image: "https://github.com/ordbase/monkesee-monkedo/raw/master/i/monke#{name}.png",
              inscriptionNumber: inscriptionNumber
            }
end

## add 1000 rocks at the end
nums = (0..999)

nums.each do |num|
  puts "==> #{num}"
  name = "%03d" % num
  blob = read_blob( "../letsrock/i/rock#{name}.png" )

  hash = Digest::SHA256.hexdigest( blob )

  puts hash

  inscriptionNumber = taken[ num ] || 1

  items << { id: hash,
             name: "##{20000+num}",
             image: "https://github.com/ordbase/letsrock/raw/master/i/rock#{name}.png",
             inscriptionNumber: inscriptionNumber
           }
end



write_json( "./items.js", items )

## hack to add const items = upfront
buf  = "// items.js generated on #{Time.now.utc}\n"
buf += "//   - mint count at #{recs.size}\n" 
buf += "\n"

buf += " const mintCount = #{recs.size};\n"
buf += " const items = " + read_text( "./items.js" )
write_text( "./items.js", buf )

puts "bye"

