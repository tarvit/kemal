module Kemal
  abstract class Controller
    getter :context

    def initialize(@context : HTTP::Server::Context)
    end

    abstract def process
  end
end
