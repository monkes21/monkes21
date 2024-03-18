require 'cocos'
require 'erb'

require_relative 'monke'
require_relative 'rock'
require_relative 'helper'



puts "monke config:"
pp MONKE



html = read_text( "./monke.html.erb" )
puts html

tmpl = ERB.new( html )
buf = tmpl.result

puts 
puts "---"
puts buf


write_text( "./tmp/index.html", buf )



html = read_text( "./rock.html.erb" )
puts html

tmpl = ERB.new( html )
buf = tmpl.result

puts 
puts "---"
puts buf

write_text( "./tmp2/index.html", buf )


puts "bye"
