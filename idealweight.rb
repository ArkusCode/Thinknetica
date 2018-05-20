#Программа для исчисления идеального веса по формуле "h - 110"
print "Ваше имя: "
name = gets.chomp.capitalize!

print "Ваш рост: "
height = gets.chomp.to_i

weight = height - 110

if weight < 0
puts "Ваш вес уже оптимален!"
  else 
  puts "#{name}, Ваш идеальный вес #{weight}кг" 
end