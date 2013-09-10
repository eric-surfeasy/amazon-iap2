class Amazon::Iap::Client
  require 'net/http'
  require 'uri'
  
  PRODUCTION_HOST = 'https://appstore-sdk.amazon.com'
  
  def initialize(developer_secret, host=nil)
    host ||= PRODUCTION_HOST
    @developer_secret = developer_secret
    @host = host
  end
  
  def verify(user_id, purchase_token, renew_on_failure=true)
    begin
      process :verify, user_id, purchase_token
    rescue Amazon::Iap::Exceptions::ExpiredCredentials => e
      raise e unless renew_on_failure
            
      renewal = renew(user_id, purchase_token)
      verify(user_id, renewal.purchase_token, false)
    end
  end
  
  def renew(user_id, purchase_token)
    process :renew, user_id, purchase_token
  end
  
  protected
  
  def process(path, user_id, purchase_token)
    path = "/version/2.0/#{path}/developer/#{@developer_secret}/user/#{user_id}/purchaseToken/#{purchase_token}"
    uri = URI.parse "#{@host}#{path}"
    Amazon::Iap::Result.new Net::HTTP.get_response(uri)
  end  
end