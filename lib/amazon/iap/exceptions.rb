module Amazon
  module Iap
    module Exceptions
      class InvalidTransaction < Exception; end
      class InvalidSharedSecret < Exception; end
      class InvalidUserId < Exception; end
      class InvalidPurchaseToken < Exception; end
      class ExpiredCredentials < Exception; end
      class InternalError < Exception; end
      class General < Exception; end
    end
  end
end