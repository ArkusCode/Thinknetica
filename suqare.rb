# Программа для решения квадратного уравнения
print "Коэффициент A = "
coef_a = gets.chomp.to_i

print "Коэффициент B = "
coef_b = gets.chomp.to_i

print "Коэффициент C = "
coef_c = gets.chomp.to_i

disc = coef_b**2 - (4 * coef_a * coef_c)

if disc < 0 
  
  puts "Дискриминант = #{disc}, корней нет"

elsif disc > 0
  x1 = (-coef_b + Math.sqrt(disc)) / (2 * coef_a)
  x2 = (-coef_b - Math.sqrt(disc)) / (2 * coef_a)

  puts "Дискриминант = #{disc}, x1 = #{x1} x2 = #{x2}"

elsif disc == 0
  x1 = (-coef_b + Math.sqrt(disc)) / (2 * coef_a)

  puts "Дискриминант = #{disc}, x = #{x1}"

end