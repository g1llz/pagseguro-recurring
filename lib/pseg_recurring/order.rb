require "rest-client"

module PsegRecurring
  class Order

    def initialize(credentials)
      @email = credentials[:email]
      @token = credentials[:token]
      @environment = credentials[:environment]
    end

    # Get orders by preapproval code
    def fetch_orders(code)
      begin
        response = RestClient.get(
          "#{@environment}/pre-approvals/#{code}/payment-orders?email=#{@email}&token=#{@token}", 
          {
            content_type: "application/json;charset=ISO-8859-1",
            accept: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
          }
        )
        xml  = Nokogiri::XML(response)
        data = Order::Serializer.new(xml).orders
        return { :error => false, :orders => data[:orders] }
        
      rescue RestClient::ExceptionWithResponse => e
        error = PsegRecurring::Error.new(e.response).process
        return { :error => true, :detail => error[:errors] }
        
      rescue StandardError => e
        Rails.logger.error { "STD ERROR -- MSG: #{e.response}" }
        return { :error => true, :detail => e.response }
      end
    end

    # Set discount in next order
    def send_discount(discount, code)
      begin
        response = RestClient.put(
          "#{@environment}/pre-approvals/#{code}/discount?email=#{@email}&token=#{@token}", 
          discount.to_json, 
          {
            content_type: "application/json;charset=ISO-8859-1",
            accept: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
          }
        )
        # if 'OK' return is empty
        Rails.logger.info { "SUCCESS -- PREAPPROVAL: #{code} > MSG: DISCOUNT APPLIED" }
        return { :error => false }

      rescue RestClient::ExceptionWithResponse => e
        error = PsegRecurring::Error.new(e.response).process
        return { :error => true, :detail => error[:errors] }

      rescue StandardError => e
        Rails.logger.error { "STD ERROR -- MSG: #{e.response}" }
        return { :error => true, :detail => e.response }
      end
    end

  end
end