require "rest-client"

module PsegRecurring
  class Session

    def initialize(credentials)
      @email = credentials[:email]
      @token = credentials[:token]
      @environment = credentials[:environment]
    end

    # Get session ID
    def session_id
      response = RestClient.post(
        "#{@environment}/v2/sessions?email=#{@email}&token=#{@token}",
        {}.to_json,
        {content_type: "application/json;charset=ISO-8859-1"}
      )
      xml  = Nokogiri::XML(response)
      data = Session::Serializer.new(xml).session
      return { :error => false, :code => data[:id] }
    
    rescue RestClient::ExceptionWithResponse  => e
      error = PsegRecurring::Error.new(e.response).process
      return { :error => true, :detail => error[:errors] }
    
    rescue StandardError => e
      Rails.logger.error { "STD ERROR -- MSG: #{e.response}" }
      return { :error => true, :detail => e.response }
    end

  end
end