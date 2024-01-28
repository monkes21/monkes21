require 'cocos'


def write_mints( path, mints )
  headers = ['num', 'ref']
  buf = ""
  buf << headers.join( ', ' )
  buf << "\n"
  mints.each do |values|
     buf << values.join( ', ' )
     buf << "\n"
  end 
  
  write_text( path, buf)  
end



def patch_mints( oldmints, duplicates: false )
  mints = []  ## new patched mint records to save

  ##
  #  check that no duplicate nums & refs
  nums = {} 
  refs = {}
    
  oldmints.each_with_index do |oldmint, i|
    ref      = oldmint['ref'].to_i(10)
    hiro_num = oldmint['num'].to_i(10)
   
    offset = if hiro_num >= 49139174  ## fix: find when switch happend?
                2
             else  ## assume assume plus one
                1
             end
   
    num = hiro_num + offset
  

    if nums.has_key?( num )
      puts "!! ERROR - duplicate num"
      exit 1
    end
    nums[ num ] = ref
  
    if duplicates == false  ## allow duplicates?
      if refs.has_key?( ref )
        puts "!! ERROR - duplicate ref"
        exit 1
      end
      refs[ ref ] = num
    end
  
    mints << [num.to_s, ref.to_s]
  end  
  mints
end



oldmints = read_csv( "./oldmint.csv" )
puts "   #{oldmints.size} old mint records"
#=> 20096 mint(s)

### sort (oldest first)
oldmints = oldmints.sort { |l,r| l['num'].to_i(10) <=> r['num'].to_i(10) }

write_mints( "./mint.csv", patch_mints( oldmints ) )


oldmints = read_csv( "./oldmint.more.csv" )
puts "   #{oldmints.size} old more mint records"
#=> 10171 more mint(s)

### sort (oldest first)
oldmints = oldmints.sort { |l,r| l['num'].to_i(10) <=> r['num'].to_i(10) }

write_mints( "./mint.more.csv", patch_mints( oldmints, duplicates: true ) )



puts "bye"

