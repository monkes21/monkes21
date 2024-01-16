
editions = 
{5=>307, 1=>12613, 3=>1846, 2=>5250, 8=>31, 13=>6, 6=>125, 10=>8, 4=>679, 11=>9, 7=>66, 9=>16, 12=>1}


pp editions


## sort by edition count key (biggest first)
sorted = editions.sort {|l,r|  r[0] <=> l[0] }
pp sorted

total = 0
sorted.each do |edition, count|
    puts "| #{edition} Editions |  #{count}  |  x#{edition} =#{count*edition} |"
    total +=  edition*count
end


puts "  #{total} monke(s)"


puts "bye"