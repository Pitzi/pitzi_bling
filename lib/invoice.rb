module Bling
  class Invoice
    attr_accessor :http_adapter, :response_handler
    attr_reader :test_mode
    alias_method :test_mode?, :test_mode

    def self.test_mode?
      Rails.env.development? or Rails.env.test?
    end

    def self.get(numero: nil, serie: nil)
      new.get(numero: numero, serie: serie)
    end

    def self.create(xml: nil)
      new.create(xml: xml)
    end

    def initialize(http_adapter: RestClientAdapter, response_handler: ResponseHandler.new)
      @http_adapter = http_adapter
      @response_handler = response_handler
    end

    def get(numero: nil, serie: nil)
      if self.class.test_mode?
        return OpenStruct.new(
          success?: true,
          invoice_key: "Rails Env: #{Rails.env}",
          danfe_link: "Rails Env: #{Rails.env}")
      end

      url = get_url(numero, serie)
      response = http_adapter.http_get(url)
      response_handler.parse_get(response)
    end

    def create(xml: nil)
      Rails.logger.info "[Bling::Invoice]"
      Rails.logger.info xml

      if self.class.test_mode?
        return OpenStruct.new(success?: true, invoice_number: 0)
      end

      url = post_url
      response = http_adapter.http_post(url, pedidoXML: xml, apiKey: Bling.apikey, retornaNumeroNota: "S")
      response_handler.parse_create(response)
    end

    private

    def get_url(numero, serie)
      "http://www.bling.com.br/recepcao.nfe.emissao.php?apiKey=#{Bling.apikey}&numero=#{numero}&serie=#{serie}&enviaEmailAoCliente=S"
    end

    def post_url
      "http://www.Bling.com.br/recepcao.nfe.php"
    end
  end
end
