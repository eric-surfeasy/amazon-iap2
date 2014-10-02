require "spec_helper"
require "amazon/iap2/client"

describe Amazon::Iap2::Client do

  subject { described_class.new secret }

  let(:secret) { "someSecret" }
  let(:receipt_id) { "12345" }
  let(:user_id) { "aUser" }

  context ".verify" do

    it "calls the verify url" do
      stub = build_stub user_id, receipt_id
      subject.verify user_id, receipt_id

      expect(stub).to have_been_requested
    end

    it "returns the result object" do
      response = build_response receipt_id
      build_stub user_id, receipt_id, 200, response

      result = subject.verify user_id, receipt_id

      expect(result.product_type).to eql(response["productType"])
      expect(result.product_id).to eql(response["productId"])
      expect(result.parent_product_id).to eql(response["parentProductId"])

      expect(result.receipt_id).to eql(response["receiptId"])
      expect(result.quantity).to eql(response["quantity"])
      expect(result.test_transaction).to eql(response["testTransaction"])
      expect(result.beta_product).to eql(response["betaProduct"])

      expect(result.purchase_date).to eql(response["purchaseDate"])
      expect(result.purchase_time).to eql(Time.at(response["purchaseDate"] / 1000))
      expect(result.cancel_date).to eql(response["cancelDate"])
      expect(result.cancel_time).to eql(Time.at(response["cancelDate"] / 1000))

    end

  end


  def build_stub(user_id, receipt_id, status=200, response=nil)
    response = build_response receipt_id unless response

    stub_request(:get, url(user_id, receipt_id)).to_return(:body => response.to_json, :status => status)
  end

  def url(user_id, receipt_id)
    "https://appstore-sdk.amazon.com/version/1.0/verifyReceiptId/developer/#{secret}/user/#{user_id}/receiptId/#{receipt_id}"
  end

  def build_response(receipt_id)
    {
      "betaProduct" => true,
      "cancelDate" => (Time.now.to_i + 2629743) * 1000, # one month from now
      "productId" => "sub1",
      "productType" => "SUBSCRIPTION",
      "purchaseDate" => Time.now.to_i * 1000,
      "receiptId" => "#{receipt_id}",
      "testTransaction" => true
    }
  end

end
