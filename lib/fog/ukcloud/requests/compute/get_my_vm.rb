module Fog
  module Compute
    class UKCloud
      class Real
        def get_my_vm

          request(
            :expects => 200,
            :method  => 'GET',
            :parser  => Fog::ToHashDocument.new,
            :path    => "#{@path}/my_vm"
          )

        end
      end
    end
  end
end
