module Psegrecurring
  class Order
    class Serializer

      def initialize(xml)
        @xml = xml
      end

      def orders
        orders = []
        @xml.css("paymentOrders > paymentOrder").each do |po|
          orders << serialize_order(po)
        end
        {}.tap do |data|
          data[:orders] = orders
        end
      end

      private

      def serialize_order(node)
        result = {}
        result.tap do |data|
          data[:code] = node.at_css("code").text
          data[:status] = node.at_css("status").text
          data[:amount] = to_amount node.at_css("amount").text
          data[:gross_amount] = to_amount node.at_css("grossAmount").text
          data[:scheduling_date] = node.css("schedulingDate").text
          data[:last_event_date] = node.css("lastEventDate").text
          data[:discount] = serialize_discount(node) if node.at_css('discount')
          data[:transactions] = serialize_transactions(node)
        end
        return result
      end

      def serialize_discount(node)
        {}.tap do |data|
          data[:type] = node.css("discount > type").text
          data[:value] = node.css("discount > value").text
        end
      end

      def serialize_transactions(node)
        node.css("transactions").map do |t|
          serialize_transaction(t)
        end
      end

      def serialize_transaction(node)
        {}.tap do |data|
          data[:code] = node.css("code").text
          data[:date] = node.css("date").text
          data[:status] = node.css("status").text
        end
      end

      def to_amount(amount)
        "%.2f" % BigDecimal(amount.to_s.to_f.to_s).round(2).to_s("F") if amount
      end

    end
  end
end