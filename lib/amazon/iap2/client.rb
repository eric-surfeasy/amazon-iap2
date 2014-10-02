class Amazon::Iap2::Client
  require 'net/http'
  require 'uri'

  PRODUCTION_HOST = 'https://appstore-sdk.amazon.com'

  def initialize(developer_secret, host=nil)
    @developer_secret = developer_secret
    @host = host || PRODUCTION_HOST
  end

  def verify(user_id, receipt_id)
    path = "/version/1.0/verifyReceiptId/developer/#{@developer_secret}/user/#{user_id}/receiptId/#{receipt_id}"
    uri = URI.parse "#{@host}#{path}"
    req = Net::HTTP::Get.new uri.request_uri
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http| http.request req }
    Amazon::Iap2::Result.new res
  end
end
