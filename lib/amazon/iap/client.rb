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
      verify(user_id, renewal['purchaseToken'], false)
    end
  end
  
  def renew(user_id, purchase_token)
    process :renew, user_id, purchase_token
  end
  
  protected
  
  def process(path, user_id, purchase_token)
    path = "/version/2.0/#{path}/developer/#{@developer_secret}/user/#{user_id}/purchaseToken/#{purchase_token}"
    uri = URI.parse "#{@host}#{path}"
    
    response = Net::HTTP.get_response uri
    
    case response.code.to_i
    when 200 then JSON.parse(response.body)
    when 400 then raise Amazon::Iap::Exceptions::InvalidTransaction
    when 496 then raise Amazon::Iap::Exceptions::InvalidSharedSecret
    when 497 then raise Amazon::Iap::Exceptions::InvalidUserId
    when 498 then raise Amazon::Iap::Exceptions::InvalidPurchaseToken
    when 499 then raise Amazon::Iap::Exceptions::ExpiredCredentials
    when 500 then raise Amazon::Iap::Exceptions::InternalError
    else raise Amazon::Iap::Exceptions::General
    end
  end  
end