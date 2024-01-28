
##
# check max filesize


files = Dir.glob( "../monkesee-monkedo/i/*.png" )
puts "  #{files.size} file(s)"
#=> 21000 file(s)


files += Dir.glob( "../letsrock/i/*.png" )
puts "  #{files.size} file(s)"
#=> 1000 files(s)    (max: 384 bytes)

max = 0
files.each do |file|
    bytes = File.size( file )
    max   = bytes > max ? bytes : max
end

puts "max:  #{max} bytes"
#=> max:  467 bytes !!!


puts "bye"