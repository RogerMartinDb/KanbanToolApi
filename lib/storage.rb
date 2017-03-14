require 'fileutils'
require 'date'

class Storage
  def initialize root
    @root = root

    if ! Dir.exist? root
      raise "Directory #{root} must exit already"
    end
  end

  def open
    temp_dir = File.join(@root, '.temp')
    if ! Dir.exist? temp_dir
      Dir.mkdir temp_dir
    end
    
    dir_name = DateTime.now.strftime("%Y-%m-%d_%s")
    @store = File.join(@root, '.temp', dir_name)
    Dir.mkdir @store

    @final = File.join(@root, dir_name)

    @store
  end

  def close
    FileUtils.mv @store, @final
  end
end
