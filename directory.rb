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
  puts "please enter the names of the students"
  puts "To finish, just hit return"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print names,filter
  names.each_with_index do |student,index|
    next if filter && filter != student[:name][0]
    next if student[:name].length > 11
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer names
  puts "Overall, we have #{names.count} great students"
end

def exercise_2
  puts "Filter by what letter, leave blank for none"
  name = gets.chomp
  name == "" ? false : name[0].upcase
end

students = input_students
filter = exercise_2
print_header
print students ,filter
print_footer students
