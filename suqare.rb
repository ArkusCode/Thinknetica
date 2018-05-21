# Программа для решения квадратного уравнения
print "Коэффициент A = "
coef_a = gets.chomp.to_f

print "Коэффициент B = "
coef_b = gets.chomp.to_f

print "Коэффициент C = "
coef_c = gets.chomp.to_f

disc = coef_b**2 - (4 * coef_a * coef_c)

if disc >= 0
  sqrt = Math.sqrt(disc)
  x1 = (-coef_b + sqrt) / (2 * coef_a)  
  x2 = (-coef_b - sqrt) / (2 * coef_a)

end

if disc < 0 
  puts "Дискриминант = #{disc}, корней нет"

elsif disc > 0
  puts "Дискриминант = #{disc}, x1 = #{x1} x2 = #{x2}"

elsif disc == 0
  puts "Дискриминант = #{disc}, x = #{x1}"

end
