module Amazon
  module Iap
    module Exceptions
      class Exception < Exception; end
      class InvalidTransaction < Amazon::Iap::Exceptions::Exception; end
      class InvalidSharedSecret < Amazon::Iap::Exceptions::Exception; end
      class InvalidUserId < Amazon::Iap::Exceptions::Exception; end
      class InvalidPurchaseToken < Amazon::Iap::Exceptions::Exception; end
      class ExpiredCredentials < Amazon::Iap::Exceptions::Exception; end
      class InternalError < Amazon::Iap::Exceptions::Exception; end
      class General < Amazon::Iap::Exceptions::Exception; end
    end
  end
end