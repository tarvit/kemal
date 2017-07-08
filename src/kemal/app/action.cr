module Kemal
  abstract class Action
    getter :context

    def initialize(@context : HTTP::Server::Context)
    end

    abstract def process
  end
end
