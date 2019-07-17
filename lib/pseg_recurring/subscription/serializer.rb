module Psegrecurring
  class Subscription
    class Serializer

      def initialize(xml)
        @xml = xml
      end

      def preapproval_code
        {}.tap do |data|
          data[:code] = @xml.css("directPreApproval > code").text
        end
      end
    
    end
  end
end
