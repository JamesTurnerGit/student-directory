@Months =["january","febuary","march","april","may","june","july","august","september","october","november","december"]
@Default_file = "students.csv"
@students = []

require "csv"

def input_students
  puts "please enter the names of the students. if you want to enter a hobby"
  puts "put a comma then type the hobby, same for cohort"
  puts "To finish, just hit return"
  puts
  input = STDIN.gets
  while !input.empty? do
    parse_student input
    puts "now, #{student_counter.downcase}"
    puts
    input = STDIN.gets.chomp
  end
  puts "done inputting students"
end

def sort_students
  #by months
  students_in_months = []
  @Months.each_with_index do |month,index|
    students_in_months << @students.select{|student| student[:cohort] == month.to_sym}
  end
  #by name
  students_in_months.map! do |month|
    month.sort{|a,b| a[:name] <=> b[:name]}
  end
  #rebuild list
  @students = []
  @Months.each_with_index do |month,index|
    @students << students_in_months[index]
  end
  @students.flatten!
end

def parse_student student
  student = student.split(",") if student.is_a? String
  student[2] = Time.now.strftime("%B").downcase  unless @Months.include?(student[2].to_s) # cohort
  @students << {name: student[0],hobby: student[1], cohort: student[2].to_sym}
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print_single_student index, student
  number_text = (index.to_s + ".").ljust 3
  name_text   = student[:name].ljust 20
  cohort_text = "(#{student[:cohort].to_s} cohort)".ljust 20
  hobby_text  = !student[:hobby].nil? && student[:hobby] != "" ? "hobbies :#{student[:hobby]}": ""
  puts "#{number_text} #{name_text} #{cohort_text} #{hobby_text}"
end

def check_filters student, filter = nil
  return false if filter && filter != student[:name][0]
  return false if student[:name].length > 20
  true
end

def print_students_list filter = nil
  sort_students
  @students.each_with_index do |student,index|
    print_single_student (index + 1),student if check_filters student,filter
  end
end

def student_counter
  case @students.length
  when 1 then return "We have 1 great student"
  when 0 then return "We have no students?"
  else "Overall, we have #{@students.count} great students"
  end
end

def show_students
  puts
  print_header
  print_students_list
  puts student_counter
  puts
end

def save_students filename = @Default_file
  CSV.open(filename,"w") do |csv|
    @students.each do |student|
      csv << [student[:name],student[:hobby],student[:cohort]]
    end
  end
  puts "saved to #{filename}."
end


def load_students filename = @Default_file
  CSV.foreach(filename) do |row|
    parse_student row
  end
  puts "Loaded #{@students.count} students from #{filename}."
end

def print_menu
  puts
  puts "main menu"
  puts "---------------"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the students"
  puts "4. loads students from file"
  puts "9. quit"
  puts
end

def save_load_wrapper method
  puts "enter filename to use, leave blank for Default"
  input = STDIN.gets.chomp
  input = @Default_file if input == ""
  method.call(input)
end

def process selection
  selection = selection.chomp.to_i
  case selection
  when 1 then input_students
  when 2 then show_students
  when 3 then save_load_wrapper method(:save_students)
  when 4 then save_load_wrapper method(:load_students)
  when 9 then exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets)
  end
end

def try_load_students
  filename = ARGV.first
  filename ||= @Default_file
  if File.exists? filename
    load_students filename
  else
    puts "file: #{filename} was not found."
    exit
  end
end

try_load_students
interactive_menu
