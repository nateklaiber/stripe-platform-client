module StripePlatform
  module Requests
    class Refunds

      def self.list(params={}, &block)
        default_query_params = {}
        default_query_params.merge!(StripePlatform::Client.default_query_params)

        params = default_query_params.merge!(params)

        request_model = StripePlatform::Requests::Models::Refunds.new(params)

        route = StripePlatform::Client.routes.route_for('refunds')
        url   = route.url_for(request_model.as_original_attributes)

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

      def self.create(record_attributes={}, params={}, &block)
        default_query_params = {}
        default_query_params.merge!(StripePlatform::Client.default_query_params)

        params = default_query_params.merge!(params)

        request_model = StripePlatform::Requests::Models::Refund.new(record_attributes)

        route = StripePlatform::Client.routes.route_for('refunds')
        url   = route.url_for(params)

        request = StripePlatform::Client.connection.post do |req|
          if block_given?
            if block.arity == 1
              req.url(url)
              yield(req)
            else
              req.url(url)
              req.instance_eval(&block)
            end
          else
            req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
            req.body = request_model.as_form_encoded
            req.url(url)
          end
        end

        StripePlatform::Response.new(request)
      end

      def self.retrieve(id, params={}, &block)
        default_query_params = {}
        default_query_params.merge!(StripePlatform::Client.default_query_params)

        params = default_query_params.merge!(params)

        route = StripePlatform::Client.routes.route_for('refund')
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

      def self.update(id, record_attributes={}, params={}, &block)
        default_query_params = {}
        default_query_params.merge!(StripePlatform::Client.default_query_params)

        params = default_query_params.merge!(params)

        request_model = StripePlatform::Requests::Models::Refund.new(record_attributes)

        route = StripePlatform::Client.routes.route_for('refund')
        url   = route.url_for(params.merge!(id: id))

        request = StripePlatform::Client.connection.post do |req|
          if block_given?
            if block.arity == 1
              req.url(url)
              yield(req)
            else
              req.url(url)
              req.instance_eval(&block)
            end
          else
            req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
            req.body = request_model.as_form_encoded
            req.url(url)
          end
        end

        StripePlatform::Response.new(request)
      end
    end
  end
end
