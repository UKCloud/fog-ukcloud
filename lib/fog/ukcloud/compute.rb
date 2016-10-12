require 'fog/xml'
require 'fog/json'

module Fog
  module Compute
    class UKCloud < Fog::Service

      recognizes :ukcloud_endpoint
      requires :ukcloud_username, :ukcloud_password
      secrets :ukcloud_password

      # Models
      model_path 'fog/ukcloud/models/compute'
      #collection :servers
      #model      :server

      # Requests
      request_path 'fog/ukcloud/requests/compute'
      #request :power_on_vm
      request :post_login_session
      request :get_my_vm
      request :get_ping

      class Real

        UKCLOUD_DEFAULT_ENDPOINT = 'portal.skyscapecloud.com'
        attr_reader :ukcloud_username, :ukcloud_endpoint, :cookies

        def initialize(options={})
          @ukcloud_username = options[:ukcloud_username]
          @ukcloud_password = options[:ukcloud_password]
          @ukcloud_endpoint = options[:ukcloud_endpoint] || UKCLOUD_DEFAULT_ENDPOINT
          @path = 'api'
          @connection_options = options[:connection_options] || {}
          @connection_options[:omit_default_port] = true unless @connection_options[:omit_default_port]
          @cookies = ''

          scheme = 'https'
          port = '443'
          url = sprintf('%s://%s:%s', scheme, @ukcloud_endpoint, port)

          @connection = Fog::XML::Connection.new(url, false, @connection_options)
        end


        def get_cookies
          login if @cookies.empty?
          @cookies
        end


        def request(params)
          path = params[:path]
          params[:body] = Fog::JSON.encode(params[:body]) if params[:body]
          begin


            headers = {
              'Accept' => 'application/json',
              'Content-Type' => 'application/json',
              'Cookie' => get_cookies
            }

            @connection.request({
              :body       => params[:body],
              :expects    => params[:expects],
              :headers    => headers.merge!(params[:headers] || {}),
              :idempotent => params[:idempotent],
              :method     => params[:method],
              :parser     => params[:parser],
              :path       => path,
              :query      => params[:query]
            })
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


        def login
          response = post_login_session
          @cookies = response.headers['Set-Cookie']
          if response[:cookies].empty? && response.status == 201 then
            err =  RuntimeError.new("No Cookie In Response")
            raise Fog::UKCloud::Errors::ServiceError.slurp(err)
          end

        end

      end #Real

      class Mock

      end

    end #UKCloud
  end #Compute
end #Fog
