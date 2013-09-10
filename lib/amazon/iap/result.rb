class Amazon::Iap::Result
  attr_accessor :item_type, :sku, :start_date, :start_time, :end_date, :end_time, :purchase_token
  
  def initialize(response)
    case response.code.to_i
    when 200
      parsed = JSON.parse(response.body)
      parsed['startTime'] = parsed['startDate'].nil? ? nil : Time.at(parsed['startDate'] / 1000)
      parsed['endTime'] = parsed['endDate'].nil? ? nil : Time.at(parsed['endDate'] / 1000)
      
      parsed.each do |key, value|
        underscore = key.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr('-', '_').downcase
        send "#{underscore}=", value
      end
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