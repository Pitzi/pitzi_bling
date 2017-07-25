module Bling
  module Loggable
    def log(message, logger = Bling.logger, level: :info)
      logger.public_send(level, message) if logger
    end
  end
end
