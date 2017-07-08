module Kemal
  class Router
    include Kemal::DSL

    def add(method, path, controller_class)
      action(method, path) do |context|
        controller_class.new(context).process
      end
    end

    def socket(path, controller_class)
      ws(path) do |socket, context|
        controller_class.new(socket, context).process
      end
    end
  end
end
