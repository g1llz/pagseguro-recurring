require "nokogiri"

module PsegRecurring
  class Error

    def initialize(response)
      @response = response
    end

    def process
      if @response.code != 400
        generic = generic(@response.code)
        Rails.logger.error { "GENERIC ERROR -- ERRORS: #{generic[:errors]}" }
        return generic
      else
        xml = Nokogiri::XML(@response)
        pagseguro = pagseguro_error(xml)
        Rails.logger.error { "PG ERROR REST -- ERRORS: #{pagseguro[:errors]}" }
        return pagseguro
      end
    end

    private
    # Process error and return messages array
    # TODO: map all possible errors;
    def pagseguro_error(xml)
      messages = []
      xml.css("errors > error").each do |error|
        messages << error_message(error.css("code").text, error.css("message").text)
      end
      {}.tap do |data|
        data[:errors] = messages
      end
    end

    # Process error and return generic messages
    def generic(code)
      {}.tap do |data|
        data[:errors] = { code: code, message: status.fetch(code.to_s.to_sym) }
      end
    end
    
    def error_message(code, message)
      begin
        br_message = Error::RecurringPayment.new(code).parse
        return { code: code, message: br_message }
      rescue => exception
        Rails.logger.error { "ERROR TRANSLATE MSG -- CODE: #{code} > ORIGINAL MSG: #{message}" }
        return { code: code, message: message }
      end
    end

    def status
      @status ||= {
        :'401' => "Não autorizado",
        :'403' => "Sem premissão para essa solicitação",
        :'404' => "Não encontrado",
        :'405' => "Método inesperado, verifique a requisição. ex: POST, GET ...",
        :'500' => "Erro interno"
      }
    end

  end
end