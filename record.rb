require_relative 'lib/raw_recorder'

folder = ARGV[0]

if (! folder.nil?) && (Dir.exist? folder)
  recorder = RawRecorder.new folder
  recorder.grab_data
else
  puts "usage: recorder.rb folder"
  puts "grabs data from KanbanTool and write it in JSON format to disk."
  puts "   folder    existing folder where Kanban Tool data will be recorded"
end
