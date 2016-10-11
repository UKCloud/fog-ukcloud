module Fog
  module UKCloud
    module Errors
      class ServiceError < Fog::Errors::Error
        attr_reader :status_code

        def self.slurp(error, service=nil)
          status_code = nil
          if error.response
            status_code = error.response.status
            unless error.response.body.empty?
              begin
                document = Nokogiri::XML(error.response.body)
                message = document.xpath('//error').text
              rescue => e
                Fog::Logger.warning("Received exception '#{e}' while decoding>> #{error.response.body}")
                message = error.response.body
              end
            end
          end

          new_error = super(error, message)
          new_error.instance_variable_set(:@status_code, status_code)
          new_error
        end
      end

      class Unauthorised < ServiceError; end
    end

  end
end
