module StripePlatform
  module Requests
    class Tokens

      def self.retrieve(id, params={}, &block)
        default_query_params = {}
        default_query_params.merge!(StripePlatform::Client.default_query_params)

        params = default_query_params.merge!(params)

        route = StripePlatform::Client.routes.route_for('token')
        url   = route.url_for(params.merge!(id: id))

        request = StripePlatform::Client.connection.get do |req|
          if block_given?
            if block.arity == 1
              req.url(url)
              yield(req)
            else
              req.url(url)
              req.instance_eval(&block)
            end
          else
            req.url(url)
          end
        end

        StripePlatform::Response.new(request)
      end
    end
  end
end
