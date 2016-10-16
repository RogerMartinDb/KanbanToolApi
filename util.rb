require 'pp'

class Util
  def to_named array
    array.map{|e| [e['name'], e]}.to_h
  end

  def print_boards boards
    boards.each do |board|
      puts
      puts board['name']
      puts "  id: #{board['id']}"
      puts "  " + board['description']
    end
  end

  def print_tasks (tasks, max)
    tasks.first(max).each do |task|
      puts
      puts task['name']
      puts "  id: #{task['id']}"
      puts "  description: #{task['description']}"
      puts "  assigned_user_id: #{task['assigned_user_id']}"
      puts "  card_type_id: #{task['card_type_id']}"
      puts "  swimlane_id: #{task['swimlane_id']}"
    end
  end

  def print_task_details task_details
    pp task_details
  end
end
