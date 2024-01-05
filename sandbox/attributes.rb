require 'cocos'


##
# read in all meta data records of all monkes (28px)
recs = read_csv( './monkes21.csv' )
puts "#{recs.size} monkes(s)"  #=> 21000 monkes(s)



counter = Hash.new(0)      # a hash (table) - let's (auto-)default to 0 for values

recs.each do |rec|
  type = rec['type']

  counter[ type ] += 1
end

pp counter

counter = counter.sort { |l,r| l[1]<=>r[1] }

counter.each do |name,count|
  percent =  Float(count*100)/Float(recs.size)

  key = name.gsub( ' ', '_' )
  puts "| ![](i/#{key}@2x.png) %-12s   | %4d  (%5.2f %%) |" % [name, count, percent]
end



puts "bye"

