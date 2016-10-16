require 'pp'
require_relative 'api'
require_relative 'util'

api = Api.new
util = Util.new

boards = api.boards

puts '________________________________________'
puts "all the boards:"
util.print_boards boards

named_boards = util.to_named boards
board = named_boards['core']

tasks = api.tasks board['id']

puts '________________________________________'
puts "first few tasks for board #{board['name']}:"
util.print_tasks tasks, 4

named_tasks = util.to_named tasks
task = named_tasks['Add lato font']

task_details = api.task_details board['id'], task['id']

puts '________________________________________'
puts "task details for task #{task_details['name']}:"
util.print_task_details task_details
