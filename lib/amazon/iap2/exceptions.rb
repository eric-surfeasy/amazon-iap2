module Amazon
  module Iap2
    module Exceptions
      class Exception < Exception; end
      class EmptyResponse < Amazon::Iap2::Exceptions::Exception; end
      class InvalidTransaction < Amazon::Iap2::Exceptions::Exception; end
      class InvalidSharedSecret < Amazon::Iap2::Exceptions::Exception; end
      class InvalidUserId < Amazon::Iap2::Exceptions::Exception; end
      class InternalError < Amazon::Iap2::Exceptions::Exception; end
      class General < Amazon::Iap2::Exceptions::Exception; end
    end
  end
end
