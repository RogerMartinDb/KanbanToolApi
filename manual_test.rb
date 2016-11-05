require 'pp'
require_relative 'api'
require_relative 'util'

api = Api.new
util = Util.new

puts '________________________________________'
puts "all the boards:"
boards = api.boards
util.print_boards boards

puts "select named board"
named_boards = util.to_named boards
board = named_boards['core']

puts '________________________________________'
puts "board settings for board #{board['name']}:"
settings = api.board_settings board
card_types = settings['card_types']
lanes = settings['workflow_stages']

pp card_types
pp lanes


puts '________________________________________'
puts "first few tasks for board #{board['name']}:"
tasks = api.tasks board
####util.print_tasks tasks, 4


puts '________________________________________'
puts "first few archived tasks for board #{board['name']}:"
tasks = api.archived_tasks board
####util.print_tasks tasks, 4

puts "select named task"
named_tasks = util.to_named tasks
task = named_tasks['Add lato font']

puts '________________________________________'
puts "task details for task #{task['name']}:"
####util.print_task_details task_details
task_details = api.task_details board, task
