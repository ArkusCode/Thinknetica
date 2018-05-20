# Программа для определения треугольника по теореме Пифагора
print "Длинна стороны A = "
side_a = gets.chomp.to_i

print "Длинна стороны B = "
side_b = gets.chomp.to_i

print "Длинна стороны C = "
side_c = gets.chomp.to_i

triangle = [side_a , side_b , side_c].sort!
sum_cat_squ = triangle[0]**2 + triangle[1]**2


if (side_a == side_b) && (side_b == side_c) 
  puts "Треугольник равносторонний, не прямоугольный"
  
  elsif (sum_cat_squ == triangle[2]**2) && (triangle[0] == triangle[1])
    puts "Треугольник равнобедренный, прямоугольный"

  elsif (sum_cat_squ == triangle[2]**2)
  	puts "Треугольник прямоугольный"

  elsif 
  	puts "Треугольник не прямоугольный"

end 		