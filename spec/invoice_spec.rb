require "spec_helper"

describe Bling::Invoice do
  describe ".get" do
    it "gets an invoice" do
      VCR.use_cassette('invoice_v1.0') do
        response = Bling::Invoice.get(numero: "000026", serie: 0)

        expect(response.success?).to eq(true)
        expect(response.invoice_key).to eq("Rails Env: test")
        expect(response.danfe_link).to eq("Rails Env: test")
      end
    end
  end

  describe ".create" do
    let(:device_shipping_address) { create(:device_shipping_address) }
    let(:device) { device_shipping_address.service_request.device }

    it "creates an invoice" do
      VCR.use_cassette('invoice_v1') do
        xml = InvoiceXmlBuilder.xml_for_invoice_in(
                                    service_request: device_shipping_address.service_request,
                                    device: Stock.find_device(device.id),
                                    notes: "")
        response = Bling::Invoice.create(xml: xml)

        expect(response.success?).to eq(true)
        expect(response.invoice_number).to eq(0)
      end
    end
  end
end
