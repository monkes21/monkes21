require 'cocos'


names = [
  'ids',
  'ids.more',
  'ids.2',  
  'ids.3',  
  'ids.4',  
  'ids.5',  
  'ids.6',  
].each do |name|
    path = "./#{name}.csv"
    recs = read_csv( path )
    puts "   #{recs.size} id records in >#{path}<"

    recs.each_with_index do |rec,i|
        num = rec['num'].to_i(10)
        hiro_num = rec['hiro'].to_i(10)
    
        offset = if hiro_num >= 49139174  ## fix: find when switch happend?
                    2
                 else  ## assume assume plus one
                    1
                 end
        if hiro_num+offset != num
            puts "!! ERROR - offset +#{offset} expected; got #{hiro_num}+#{offset} != #{num}:"
            pp rec
            exit 1 
        end
    
        print "."  if i % 100 == 0
    end
    print "\n"    
end


puts "bye"

