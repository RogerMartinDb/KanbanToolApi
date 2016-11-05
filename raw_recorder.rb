require 'date'
require 'json'
require_relative 'api'

class RawRecorder
  def initialize root
    if ! Dir.exist? root
      raise "Directory #{root} must exit already"
    end

    now = DateTime.now
    @root = File.join(root, now.strftime("%Y-%m-%d_%s"))
    Dir.mkdir @root

    @api = Api.new
  end

  def grab_data
    @api
      .boards
      .each{|board| grab_board board}
    puts 'Done.'
  end

  def grab_board board
    settings = @api.board_settings board
 
    board_dir = File.join(@root, board['name'])
    Dir.mkdir board_dir

    json_to_file board_dir, 'board', board
    json_to_file board_dir, 'card_types', settings['card_types']
    json_to_file board_dir, 'lanes', settings['workflow_stages']

    store_tasks board, board_dir, 'open_tasks', @api.tasks(board)
    store_tasks board, board_dir, 'archived_tasks', @api.archived_tasks(board)  
  end

  def store_tasks board, board_dir, name, tasks
    tasks_dir = File.join(board_dir, name)
    Dir.mkdir tasks_dir

    tasks.each do |task|
      json_to_file tasks_dir, task['id'], task

      task_details = @api.task_details board, task
      json_to_file tasks_dir, task['id'].to_s + '_details', task_details
    end
  end

  def json_to_file folder, name, object
    json = JSON.pretty_generate object
    File.write(File.join(folder, "#{name}.json"), json)
  end

end
