module Fog
  module Compute
    class UKCloud
      class Real
        def post_login_session
          headers = {
            'Authorization' => "Basic #{Base64.encode64("#{@ukcloud_username}:#{@ukcloud_password}").delete("\r\n")}"
          }

          request(
            :expects => 200,
            :headers => headers,
            :method  => 'POST',
            :parser  => Fog::ToHashDocument.new,
            :path    => "#{@path}/authenticate"
          )
        end
      end
    end
  end
end
