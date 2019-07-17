module Psegrecurring
  class Plan
    class Serializer

      def initialize(xml)
        @xml = xml
      end

      def plan_code
        {}.tap do |data|
          data[:code] = @xml.css('preApprovalRequest > code').text
        end
      end
    
    end
  end
end