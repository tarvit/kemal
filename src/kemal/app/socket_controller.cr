module Kemal
  abstract class SocketController
    getter :context, :socket

    def initialize(@socket : HTTP::WebSocket, @context : HTTP::Server::Context)
    end

    abstract def process
  end
end
