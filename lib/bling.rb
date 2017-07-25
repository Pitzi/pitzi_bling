module Bling
  require "bling/invoice"
  require "bling/invoice_xml"
  require "bling/transporte_xml"

  BASE_URL = 'https://bling.com.br/Api/v2'
  class << self
    attr_accessor :logger, :apikey
  end

  def self.configure
    yield self
  end
end
