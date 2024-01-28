##
# check image hash
# to run use
#
#  $  ruby -r cocos base.rb



files = Dir.glob( "../monkesee-monkedo/i/*.png" )
puts "  #{files.size} file(s)"


## note: cut off last 1000!
files = files.sort
files = files[0,20000]

puts "  #{files.size} file(s)"
puts "  from: #{files[0]}, to: #{files[-1]}"
#=>  ../monkesee-monkedo/i/monke00000.png to ../monkesee-monkedo/i/monke19999.png



HASHES = {}

files.each_with_index do |file,i|
   basename=File.basename( file, File.extname( file))
   num = basename.sub( 'monke', '' ).to_i(10)

   blob = read_blob( file )
   hash = Digest::SHA256.hexdigest( blob )
   HASHES[ hash ] ||= []
   HASHES[ hash] << num

   print "."
   print i    if i % 100 == 0
end
print "\n"



######
# add 1000 rocks

files = Dir.glob( "../letsrock/i/*.png" )
puts "  #{files.size} file(s)"

files.each_with_index do |file,i|
   basename=File.basename( file, File.extname( file))
   num = basename.sub( 'rock', '' ).to_i(10)

   blob = read_blob( file )
   hash = Digest::SHA256.hexdigest( blob )
   HASHES[ hash ] ||= []
   HASHES[ hash] << (num+20000)

   print "."
   print i    if i % 100 == 0
end
print "\n"


###
#  first-is-first - unique hash with first image only
HASHES_FIRST = HASHES.reduce( {} ) { |h,(hash,nums)| h[hash] = nums[0]; h }

puts "  #{HASHES_FIRST.size} unique (first-is-first) hashes"
#=>  20957 unique (first-is-first) hashes


## print duplicates:

## check if any duplicates?
duplicates = Hash.new(0)
HASHES.each do |hash, nums|
    if nums.size > 1
        puts "!! #{hash}"
        pp nums

        duplicates[nums.size] += 1 
    end
end


puts "duplicates:"
pp duplicates
## { 2=>35,
#    3=>4}

__END__

duplicates (35):   first-is-first, second-is-second

!! f4bf25a551e851e9eaacb190d10d0f4010784dddc780eb153aced1b4f7d9e96e
[127, 17677]
!! 563ae745287d6aa9e37f62f4c6780411f028aeaeb7b2575f7d80e2f7284e91b0
[174, 1734]
!! cba401264896bba25179bb0f17565e839267833ff237133bc64b02c9119c234f
[309, 13179]
!! 25308011cd325eeeae67bb3b69ebef8bcc4cccd66067ffd5db6421892e63c4a8
[348, 3078]
!! 0621d98c9a561a1e0582d0613865328545556445accc7c4f63171dacf04aaf7d
[595, 11125]
!! 217fa4dc44588cd73d7df31942c0affdcd04bc7955221055f662ed51bcf44184
[659, 8069]
!! f7764d21b0a63eccf9f76cf406f6557b60951a2599925ddfab2895cd64fa8290
[1700, 7160]
!! bec86cad11a415b2c17479729678837ce80bb47e5cc6c29f162b318c2b63c3fb
[1803, 8433]
!! 81710ee93803f109970b6a0201a129c7d1e6abe46bef1719b968c42b75937970
[2079, 2131]
!! b771801b7625f19989e4fb89b413219496c59cd576a4155b1180e64fec07f872
[2729, 5693]
!! 55b070c55f9fd2f228bee29eee0142177d2e3e6debfd57d26cb2dccd76c74e58
[2817, 18417]
!! 43ee770855a3c48c7e1b122ee14856958a6bcb1fda9492f7c1a9cfe893cc5900
[3104, 12854]
!! 3462c4fe34d9459eee1e17bb3dda85468b4959641bcc1a190f5b91e068f60ff7
[3145, 7877]
!! d8f924997ca5e2fc41101e2afa3c216bb75cbb34b74e9c3077d09d91d78354bb
[3169, 18769]
!! 7179cb8cc765a19435dfd4a18b3faf81cbc336b47ced2f3db8a2529aff22b8c6
[3260, 15350]
!! e4d7386f4ffdaea66971c9b0bfe71282d9babb25d95a2d450afb194e8005f970
[3509, 11985]
!! 72a1e2f00c87072b43d60a92344fa9827bf498a98decb9b512b27701c2e5323c
[3769, 4393]
!! 2bb54a03c98a245923fc5897634d587d1f6627098ce1529ead1021dceb92d7db
[4022, 17672]
!! 7b598539a643399d1f965e9314e6bd9e98d93033c086558110e760cb070a3553
[4211, 15157]
!! b282972f8e8dd4b77c65ec2ceae42d439ccc9f7c4858082f298163afbe081c7a
[4724, 19154]
!! 504a5bd3c77af40afebfd93aecedc598f24b595e0afcceeadcb5fee0b7f05342
[5157, 13737]
!! ae6cf0a67e436a89cb2aae5783ed9a18932e9a450cc2f5a6b692138f27ba4f48
[5345, 18995]
!! 2f0a267d61dcdc6a5ae584c0de5edf5560318ba1ec3895baf3b23317ea037ee0
[6837, 11179]
!! 9bef26e8d07d76ac5cc4221ed08195556c35a05173474ef7f6ab24060be206e7
[6856, 7636]
!! ca25f05a23d793de126175f485e9ae50fa48cb663a95546a128fdb845940ced6
[7680, 17820]
!! dfa3e280f785e3f7c76e11ebdf97e5c6dcc72613088ff76c29ab0a7289baf3f1
[7903, 14897]
!! e04b83ac3ea6459b8a51db892d97da497790035c4c98510a65b10c4f81676352
[8629, 16429]
!! f5c4225db5fe6e7698e3b696ce601117e015372a2debe145d9cf73316b17e629
[9032, 16832]
!! 81a6637cc8b3528830d46cdf3963bec801e194f8fb8ae087391295e3a12cc679
[9603, 13503]
!! ad56db6947e4a97e34372bb55d63f4bd3502c2f7eb63c1a4c2f3ed0b825b35a3
[9827, 11465]
!! 2f229e3a3899ea2f8ce0ecb3ad40502841a63d59beec5225923891502bc630c5
[10943, 12893]
!! 8dc2f3407c0efb560e2dc2b46d8b0979862ada4bb2480e96f1f2d4199249cd99
[10945, 12973]
!! 2d1e17f0ecd25a6a0e5047585148349337b9307409d3cf910912bbf369e0f011
[12186, 18816]
!! ddc5018916244347cf5b7033824bf0874f45a75fa95cc3f7c0b3da431c66c716
[14136, 19206]
!! d50d1813ce4e8e63792c35cb2e22c6197b06e550e954d19e81925494281c6b91
[20063, 20543]


triplicates (4):  first-is-first, second-is-second, third-is-third

!! 8b43d085f58d1e3d9f4c19bbd853d1fda59deab99afb16710af240ad5bb351c2
[2105, 3795, 14221]
!! 3259208a72b34c9558c20d1315077e2cbf459ac22e4bb07cfe64877e9c6b0aa5
[2937, 8423, 13961]
!! 48b9497602d6877c543ff0aac83f332cf66532a73460f444542e143e25d2dce6
[3457, 8397, 10139]
!! bee699c5d8e25bce48f8fc7b74b32575160c2c8acdde03da2f4a037c2eb2eefd
[4939, 6967, 9983]
