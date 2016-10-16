require 'net/http'
require 'json'

class Api

  def boards
    call 'boards', 'board'
  end

  def tasks(board_id)
    call "boards/#{board_id}/tasks", 'task'
  end

  def task_details(board_id, task_id)
    call "boards/#{board_id}/tasks/#{task_id}", 'task'
  end

  @@root_url = 'https://fusioneer.kanbantool.com/api/v1/'

  private
  def api_token
    api_token = ENV['KANBANTOOL_API_TOKEN']
    if api_token.nil? 
      raise 'You must set environment variable KANBANTOOL_API_TOKEN, see http://kanbantool.com/about/api#getting-started'
    end
    api_token
  end

  private 
  def call(resource, wrapper)
    uri = URI("#{@@root_url}#{resource}.json?api_token=#{api_token}")
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    unwrapJSON response, wrapper
  end

  # fix odd JSON response
  # see, http://kanbantool.com/about/api#interface
  def unwrapJSON(raw, wrapper)
    if raw.is_a?(Array) 
      raw.map {|e| e[wrapper]}
    else
      raw[wrapper]
    end
  end
end
