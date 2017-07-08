# The DSL currently consists of
# - get post put patch delete options
# - WebSocket(ws)
# - before_*
# - error

module Kemal
  module DSL
    HTTP_METHODS   = %w(get post put patch delete options)
    FILTER_METHODS = %w(get post put patch delete options all)

    {% for method in HTTP_METHODS %}
      def {{method.id}}(path, &block : HTTP::Server::Context -> _)
        action({{method}}, path, &block)
      end
    {% end %}

    def action(action_name, path, &block : HTTP::Server::Context -> _)
      raise Kemal::Exceptions::InvalidPathStartException.new(action_name, path) unless Kemal::Utils.path_starts_with_slash?(path)
      Kemal::RouteHandler::INSTANCE.add_route(action_name.upcase, path, &block)
    end

    def ws(path, &block : HTTP::WebSocket, HTTP::Server::Context -> Void)
      raise Kemal::Exceptions::InvalidPathStartException.new("ws", path) unless Kemal::Utils.path_starts_with_slash?(path)
      Kemal::WebSocketHandler.new path, &block
    end

    def error(status_code, &block : HTTP::Server::Context, Exception -> _)
      Kemal.config.add_error_handler status_code, &block
    end

    # All the helper methods available are:
    #  - before_all, before_get, before_post, before_put, before_patch, before_delete, before_options
    #  - after_all, after_get, after_post, after_put, after_patch, after_delete, after_options
    {% for type in ["before", "after"] %}
      {% for method in FILTER_METHODS %}
        def {{type.id}}_{{method.id}}(path = "*", &block : HTTP::Server::Context -> _)
         Kemal::FilterHandler::INSTANCE.{{type.id}}({{method}}.upcase, path, &block)
        end
      {% end %}
    {% end %}
  end

  extend DSL
end
