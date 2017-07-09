module Kemal
  class Router
    include Kemal::DSL

    def add(method, path, action_class)
      action(method, path) do |context|
        action_class.new(context).process
      end
    end

    def socket(path, action_class)
      ws(path) do |socket, context|
        action_class.new(socket, context).process
      end
    end
  end
end
