@Months =["january","febuary","march","april","may","june","july","august","september","october","november","december"]

def input_students
  puts "please enter the names of the students. if you want to enter a hobby"
  puts "put a comma then type the hobby, same for cohort"
  puts "To finish, just hit return"
  students = []
  input = gets.gsub(/\n/,"").split(/,/)
  while !input.empty? do
    input[2] = Time.now.strftime("%B").downcase  unless @Months.include?(input[2].to_s)
    students << {name: input[0],hobby: input[1], cohort: input[2].to_sym}
    puts "now, #{student_counter(students)}"
    input = gets.gsub(/\n/,"").split(/,/)
  end
  if students.empty?
     puts student_counter students
     exit
  else
     students
  end
end

def student_counter names
  case names.length
  when 1 then return "We have 1 great student"
  when 0 then return "We have no students?"
  else "Overall, we have #{names.count} great students"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "---------------"
end

def print_out names,filter
  index = 1
  while names.length > 0
    names = names.sort do |x,y|
       @Months.find_index(x[:cohort].to_s) <=> @Months.find_index(y[:cohort].to_s)
    end
    student = names.shift
    next if filter && filter != student[:name][0]
    next if student[:name].length > 30
    name_text  = "#{student[:name]}".ljust 30
    cohort_text  = "(#{student[:cohort]} cohort)".ljust 20
    hobby_text = student[:hobby] && student[:hobby] != "" ? "hobbies :#{student[:hobby]}": ""
    puts "#{(index.to_s + ".").ljust(3)} #{name_text} #{cohort_text} #{hobby_text}"
    index += 1
  end
  return nil
end

def print_footer names
  puts student_counter names
end

def get_filter
  puts "Filter by what letter, leave blank for none"
  name = gets.chomp
  name == "" ? false : name[0].upcase
end


def interactive_menu
  filter_character = nil ## will fix or remove this later
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. quit"
    input = gets.to_i
    case input
    when 1
      students = input_students
    when 2
      puts 
      print_header
      print_out(students.clone ,filter_character)
      print_footer students
      puts
    when 9
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
