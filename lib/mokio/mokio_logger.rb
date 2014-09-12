class MokioLogger 
  # new logger object 
  @@mokiologger = Logger.new("log/#{Rails.env}_mokio.log")
  #initialize and set debug level
  def initialize
     level =  defined?(Rails.configuration.mokio_log_level) ? Rails.configuration.mokio_log_level : Logger::INFO
     @@mokiologger.level = level
  end
  # methods for logged info , error ,debug , warn  msg
  def info(msg)
    @@mokiologger.info(msg)
  end

  def debug(msg) 
    @@mokiologger.debug(msg)
  end

  def error(msg) 
    @@mokiologger.error(msg)
  end
  
  def warn(msg) 
    @@mokiologger.warn(msg)
  end
end
