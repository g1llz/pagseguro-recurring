module Psegrecurring
  class Session
    class Serializer

      def initialize(xml)
        @xml = xml
      end

      def session
        {}.tap do |data|
          data[:id] = @xml.css("id").text
        end
      end

    end
  end
end