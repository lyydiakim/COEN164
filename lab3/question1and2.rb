
# question 1

File.open("text.txt", "r") do |file|

  file.each_with_index do |line, index|
    # print even numbered lines
    puts line if !index.even?
  end
end


#  question 2

port = ARGV[0]

if port.nil?
  puts "Please provide a port number"
  exit  
end
if Integer(port) && port[0]!='0' && (port.length>=4 && port.length <= 5)
    puts "ARGV0 IS A NUMBER"
else
    puts "ARGV0 IS NOT A NUMBER"
    return
end



require 'socket'
Socket.tcp_server_loop(port) do |connection| 
    connection.close
end
