module Mokio
  class Logger 
    #initialize and set debug level
    def initialize
      level =  Mokio.mokio_log_level
      @@mokiologger ||= ::Logger.new("#{Rails.root}/log/#{Rails.env}_mokio.log")
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
end
