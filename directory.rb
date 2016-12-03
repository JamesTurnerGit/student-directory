student_count = 11
#array students
students =["Dr. Hannibal Lecter",
           "Darth Vader",
           "Nurse Ratched",
           "Micheal Corleone",
           "Alex DeLarge",
           "The Wicked Witch of the West",
           "T-2000",
           "Freddy Krueger",
           "The Jocker",
           "Joffrey Baratheon",
           "Norman  Bates"]

puts "The students of Villains Academy"
puts "---------------"
students.each do |student|
  puts student
end
#then print total number
puts "Overall, we have #{students.count} great students"
