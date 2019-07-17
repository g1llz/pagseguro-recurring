require "rest-client"

module PsegRecurring
  class Plan

    def initialize(credentials)
      @email = credentials[:email]
      @token = credentials[:token]
      @environment = credentials[:environment]
    end

    # Create a new plan
    def send_plan(plan)
      begin
        response = RestClient.post(
          "#{@environment}/pre-approvals/request?email=#{@email}&token=#{@token}",
          plan.to_json,
          {
            content_type: "application/json;charset=ISO-8859-1",
            accept: "application/vnd.pagseguro.com.br.v3+xml;charset=ISO-8859-1"
          }
        )
        xml  = Nokogiri::XML(response)
        data = Plan::Serializer.new(xml).plan_code
        Rails.logger.info { "SUCCESS -- PLANCODE: #{data[:code]} > MSG: CREATED PLAN" }
        return { :error => false, :code => data[:code] }

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