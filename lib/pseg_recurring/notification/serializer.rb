module Psegrecurring
  class Notification
    class Serializer

      def initialize(xml)
        @xml = xml
      end

      def preApproval
        {}.tap do |data|
          data[:code] = @xml.at_css("code").text
          data[:status] = @xml.at_css("status").text
          data[:reference] = @xml.at_css("reference").text
          data[:last_event_date] = @xml.css("lastEventDate").text
        end
      end

      def transaction
        {}.tap do |data|
          data[:status] = @xml.at_css("status").text
          data[:reference] = @xml.at_css("reference").text
          data[:last_event_date] = @xml.css("lastEventDate").text
          data[:gross_amount] = to_amount @xml.css("grossAmount").text
          data[:discount_amount] = @xml.css("discountAmount").text
        end
      end
      
      private
        def to_amount(amount)
          "%.2f" % BigDecimal(amount.to_s.to_f.to_s).round(2).to_s("F") if amount
        end

    end
  end
end
