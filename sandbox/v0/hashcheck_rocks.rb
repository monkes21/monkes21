require 'cocos'

require 'digest'



##
# check image hash

files = Dir.glob( "../letsrock/i/*.png" )
puts "  #{files.size} file(s)"
#=> 1000 file(s)


hashes = {}

files.each_with_index do |file,i|
   basename=File.basename( file, File.extname( file))
   num = basename.sub( 'rock', '' ).to_i(10)

   blob = read_blob( file )
   hash = Digest::SHA256.hexdigest( blob )
   hashes[ hash ] ||= []
   hashes[ hash] << num

   print "."
   print i    if i % 100 == 0
end
print "\n"

## check if any duplicates?
duplicates = Hash.new(0)
hashes.each do |hash, nums|
    if nums.size > 1
        puts "!! #{hash}"
        pp nums

        duplicates[nums.size] += 1 
    end
end


puts "duplicates:"
pp duplicates

puts "bye"


__END__

!! d50d1813ce4e8e63792c35cb2e22c6197b06e550e954d19e81925494281c6b91
[63, 543]
duplicates:
{2=>1}