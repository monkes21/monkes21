require 'cocos'
require 'digest'


require_relative 'base'    ## build HASHES lookup/table


def find_record( num )
  HASHES.each do |hash, nums|
      return [hash, nums]  if nums.include?( num )
  end
  puts "!! ERROR - not found"
  exit 1
end


##
## takens
##  
recs = read_csv( "./mint.csv" )
puts "   #{recs.size} taken record(s)"

recs = recs.sort { |l,r|  l['ref'].to_i(10) <=> r['ref'].to_i(10) }

refs = recs.reduce( {} ) do |h,rec|
                              ref = rec['ref'].to_i(10)
                              num = rec['num'].to_i(10)  
                            h[ref] = num 
                            h 
                         end 

missing = []


21000.times do |num|

  if !refs.has_key?( num )
    puts
    puts "!! #{num}"

    hash, nums = find_record( num )
    puts "  #{hash}"
    puts "  " + nums.pretty_inspect

    missing << num   
  end
end

puts
puts
puts missing.join( ' ' )
puts "   #{missing.size} not indexed"


puts "bye"


__END__

1734 
2131 
3078 3795 
4393 
7636 
8069 
8433 
10139 
11179 11985 
12854 
13737 13961 
14221 14897 
15350 
17672 17820 
18417 
19206 
20543