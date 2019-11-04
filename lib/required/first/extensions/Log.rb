# encoding: UTF-8

class Log
class << self

  def write message
    rf.write("#{Time.now} --- #{message}\n")
  end

  def rf
    @rf ||= begin
      File.unlink(path) if File.exists?(path)
      File.open(path,'a')
    end
  end
  def path
    @path ||= File.join(APPFOLDER,'ope.log')
  end
end #/<< self
end #/Log

def log message
  Log.write(message)
end
