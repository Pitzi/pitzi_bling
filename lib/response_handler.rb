module Bling
  class ResponseHandler
    def parse_get(response)
      if response.status == 200
        parsed_response = Hash.from_xml(response.body)
        if parsed_response["xmlResponse"]["situacao"] == "2"
          OpenStruct.new(success?: true,
                         invoice_key: parsed_response["xmlResponse"]["chaveAcesso"],
                         danfe_link: parsed_response["xmlResponse"]["linkDanfe"])
        else
          failure_request_for(response)
        end
      else
        failure_request_for(response)
      end
    end

    def parse_create(response)
      if response.status == 200
        if response.body != "Ja existe uma nota fiscal cadastrada com este XML."
          OpenStruct.new(success?: true, invoice_number: response.body)
        else
          failure_request_for(response)
        end
      else
        failure_request_for(response)
      end
    end

    private

    def failure_request_for(response)
      OpenStruct.new(success?: false, body: response.body)
    end
  end
end
