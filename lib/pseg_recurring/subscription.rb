require "rest-client"

module PsegRecurring
  class Subscription

    def initialize(credentials)
      @email = credentials[:email]
      @token = credentials[:token]
      @environment = credentials[:environment]
    end
    
    # Create a new subscription
    def send_subscription(sender)
      begin
        response = RestClient.post(
          "#{@environment}/pre-approvals?email=#{@email}&token=#{@token}", 
          sender.to_json, 
          {
            content_type: "application/json;charset=ISO-8859-1",
            accept: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
          }
        )
        xml  = Nokogiri::XML(response)
        data = Subscription::Serializer.new(xml).preapproval_code
        Rails.logger.info { "SUCCESS -- PREAPPROVAL: #{data[:code]} > MSG: SUBSCRIBED" }
        return { :error => false, :code => data[:code] }

      rescue RestClient::ExceptionWithResponse => e
        error = PsegRecurring::Error.new(e.response).process
        return { :error => true, :detail => error[:errors] }

      rescue StandardError => e
        Rails.logger.error { "STD ERROR -- MSG: #{e.response}" }
        return { :error => true, :detail => e.response }
      end
    end

    # Cancel subscription
    def send_subscription_cancel(code) 
      begin
        response = RestClient.put(
          "#{@environment}/pre-approvals/#{code}/cancel?email=#{@email}&token=#{@token}", 
          {}.to_json, 
          {
            content_type: "application/json;charset=ISO-8859-1",
            accept: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
          }
        )
        # if 'OK' return is empty
        Rails.logger.info { "SUCCESS -- PREAPPROVAL: #{code} > MSG: CANCELLED" }
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