module Bling
  class RestClientAdapter
    extend Loggable

    def self.http_get url, headers = {}
      log "RestClientAdapter::http_get url: #{url} headers: #{headers}"
      response = RestClient.get(url, headers)
      log "RestClientAdapter::http_get response: #{response.inspect}"

      OpenStruct.new(:status => response.code, :body => response.body)

    rescue RestClient::Exception, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError => e
      raise ServiceNotAvailableError, e.message
    end
    
    def self.http_post url, params = {}
      log "RestClientAdapter::http_post url: #{url} params: #{params}"
      response = RestClient.post(url, params)
      log "RestClientAdapter::http_post response: #{response.inspect}"

      OpenStruct.new(:status => response.code, :body => response.body)

    rescue RestClient::Exception, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError => e
      raise ServiceNotAvailableError, e.message
    end
  end
end
