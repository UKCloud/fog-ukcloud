require 'fog/json'

module Fog
  module Compute
    class UKCloud
      class Real
        def post_login_session

          body = {
            :email => @ukcloud_username,
            :password => @ukcloud_password
          }

          begin

            @connection.request(
              :headers => {'Accept' => 'application/json'},
              :expects => 201,
              :method  => 'POST',
              :body => Fog::JSON.encode(body),
              :path    => "#{@path}/authenticate"
            )
          rescue Excon::Errors::HTTPStatusError => error
            raise case error
              when Excon::Errors::BadRequest   then Fog::UKCloud::Errors::BadRequest.slurp(error);
              when Excon::Errors::Unauthorized then Fog::UKCloud::Errors::Unauthorised.slurp(error);
              when Excon::Errors::Forbidden    then Fog::UKCloud::Errors::Forbidden.slurp(error);
              when Excon::Errors::Conflict     then Fog::UKCloud::Errors::Conflict.slurp(error);
            else
              Fog::UKCloud::Errors::ServiceError.slurp(error)
            end
          end


        end
      end
    end
  end
end
