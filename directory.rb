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

def input_students
  puts "please enter the names of the students"
  puts "To finish, just hit return twice"
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

def print names
  names.each_with_index do |student,index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer names
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print students
print_footer students
