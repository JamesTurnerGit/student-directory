def input_students
  puts "please enter the names of the students if you want to enter a hobby"
  puts "put a comma then type the hobby"
  puts "To finish, just hit return"
  students = []
  input = gets.chomp.split(/,/)
  while !input.empty? do
    students << {name: input[0],hobby: input[1], cohort: :november}
    puts "Now we have #{students.count} students"
    input = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print_out names,filter
  index = 1
  while names.length > 0
    student = names.shift
    next if filter && filter != student[:name][0]
    next if student[:name].length > 11
    name_text  = "#{student[:name]}"
    cohort_text  = "(#{student[:cohort]} cohort)"
    hobby_text = student[:hobby] ? "hobbies :#{student[:hobby]}": ""
    puts "#{(index.to_s + ".").ljust(3)} #{name_text.ljust(15)} #{cohort_text.ljust 20} #{hobby_text.ljust 20}"
    index += 1
  end
  return nil
end

def print_footer names
  puts "Overall, we have #{names.count} great students"
end

def get_filter
  puts "Filter by what letter, leave blank for none"
  name = gets.chomp
  name == "" ? false : name[0].upcase
end

students = input_students
filter_character = get_filter

print_header
print_out(students.clone ,filter_character)
print_footer students
