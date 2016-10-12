module Fog
  module Compute
    class UKCloud
      class Real
        def get_ping

          request(
            :expects => 200,
            :method  => 'GET',
            #:parser  => Fog::ToHashDocument.new,
            :path    => "#{@path}/ping"
          )

        end
      end
    end
  end
end
