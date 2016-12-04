@Months =["january","febuary","march","april","may","june","july","august","september","october","november","december"]
@students = []

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
end

def parse_student student
  student = student.chomp.split(/,/)
  student[1] = !student[1].nil? && student[1] != "" ? "hobbies :#{student[1]}": "" # hobby
  student[2] = Time.now.strftime("%B").downcase  unless @Months.include?(student[2].to_s) # cohort
  @students << {name: student[0],hobby: student[1], cohort: student[2].to_sym}
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print_students_list filter = nil
  names = @students.clone
  index = 1
  while names.length > 0
    names = names.sort do |x,y|
       @Months.find_index(x[:cohort].to_s) <=> @Months.find_index(y[:cohort].to_s)
    end
    student = names.shift
    next if filter && filter != student[:name][0]
    next if student[:name].length > 30
    number_text = (index.to_s + ".").ljust 3
    name_text = student[:name].ljust 30
    cohort_text = student[:cohort].to_s.ljust 15
    hobby_text = student[:hobby]
    puts "#{number_text} #{name_text} #{cohort_text} #{hobby_text}"
    index += 1
  end
  return nil
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

def get_filter
  puts "Filter by what letter, leave blank for none"
  name = gets.chomp
  name == "" ? false : name[0].upcase
end

def save_students
  file = File.open "students.csv", "w"
  @students.each do |student|
    student_data = [student[:name],student[:hobby],student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students filename = "students.csv"
  file = File.open filename, "r"
  file.readlines.each do |line|
    parse_student line
  end
  file.close
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

def process selection
  selection = selection.chomp.to_i
  case selection
  when 1 then input_students
  when 2 then show_students
  when 3 then save_students
  when 4 then load_students
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
  return if filename.nil?
  if File.exists? filename
    load_students filename
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "file: #{filename} was not found."
    exit
  end
end

try_load_students
interactive_menu
