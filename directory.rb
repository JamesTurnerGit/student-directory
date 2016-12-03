#array of students
=begin
students =[
  {name: "Dr. Hannibal Lecter",         cohort: :november},
  {name: "Darth Vader",                 cohort: :november},
  {name: "Nurse Ratched",               cohort: :november},
  {name: "Micheal Corleone",            cohort: :november},
  {name: "Alex DeLarge",                cohort: :november},
  {name: "The Wicked Witch of the West",cohort: :november},
  {name: "T-2000",                      cohort: :november},
  {name: "Freddy Krueger",              cohort: :november},
  {name: "The Jocker",                  cohort: :november},
  {name: "Joffrey Baratheon",           cohort: :november},
  {name: "Norman  Bates",               cohort: :november}]
=end

#options for different exercises that mess with the output too much to be
#sensible

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
    puts "#{index}. #{name_text} #{cohort_text} #{hobby_text}"
    index += 1
  end
  puts names
  return nil
end

def print_footer names
  puts names
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
puts students
print_out (students , filter_character)
puts students
print_footer students
