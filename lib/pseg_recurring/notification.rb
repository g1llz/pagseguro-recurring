require "rest-client"

module PsegRecurring
  class Notification

    def initialize(credentials)
      @email = credentials[:email]
      @token = credentials[:token]
      @environment = credentials[:environment]
    end

    def receive(notification_code, notification_type)
      begin
        response = RestClient.get(
          "#{@environment}/#{path.fetch(notification_type.to_sym)}/notifications/#{notification_code}?email=#{@email}&token=#{@token}", 
          headers.fetch(notification_type.to_sym)
        )
        xml  = Nokogiri::XML(response)
        data = notification_type == "preApproval" ? Notification::Serializer.new(xml).preApproval : Notification::Serializer.new(xml).transaction
        return { :error => false, :data => data }
        
      rescue RestClient::ExceptionWithResponse => e
        error = PsegRecurring::Error.new(e.response).process
        return { :error => true, :detail => error[:errors] }
        
      rescue StandardError => e
        Rails.logger.error { "STD ERROR -- MSG: #{e.response}" }
        return { :error => true, :detail => e.response }
      end
    end
    
    private
      def path
        @path ||= {
          preApproval: "pre-approvals",
          transaction: "v3/transactions"
        }
      end

      def headers
        @headers ||= {
          preApproval: {
            content_type: "application/json;charset=ISO-8859-1",
            accept: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
          },
          transaction: {
            content_type: "application/json;charset=ISO-8859-1"
          }
        }
      end  

  end
end