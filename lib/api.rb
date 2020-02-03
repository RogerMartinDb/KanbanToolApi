require 'net/http'
require 'json'

class Api

  @@root_url = 'https://fusioneer.kanbantool.com/api/v1/'

  def boards
    call 'boards', 'board'
  end

  def board_settings board
    call "boards/#{board['id']}", 'board'
  end

  def tasks board 
    call "boards/#{board['id']}/tasks", 'task'
  end

  def archived_tasks board
    tasks = []
    page = 1
    per_page = 175
    finished = false
    while ! finished do
      response = call "boards/#{board['id']}/tasks", 'task', "archived=1&page=#{page}&per_page=#{per_page}"
      tasks += response
      page += 1
      finished = response.length < per_page
    end
    tasks
  end

  def task_details board, task
    call "boards/#{board['id']}/tasks/#{task['id']}", 'task'
  end

  private
  def api_token
    api_token = ENV['KANBANTOOL_API_TOKEN']
    if api_token.nil? 
      raise 'You must set environment variable KANBANTOOL_API_TOKEN, see http://kanbantool.com/about/api#getting-started'
    end
    api_token
  end

  private 
  def call(resource, wrapper, params = '')
    url = "#{@@root_url}#{resource}.json?api_token=#{api_token}"
    url += "&#{params}" unless params.empty?
    puts url
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    unwrapJSON response, wrapper
  end

  # "fix"" odd JSON response
  # see, http://kanbantool.com/about/api#interface
  def unwrapJSON(raw, wrapper)
    if raw.is_a?(Array) 
      raw.map {|e| e[wrapper].nil? ? e : e[wrapper]}
    else
      raw[wrapper]
    end
  end
end
