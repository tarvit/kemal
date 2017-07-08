module Kemal
  class Application
    @@app = new
    class_getter :app

    @router = Kemal::Router.new
    getter :router

    def self.run
      Kemal.run
    end

    def self.configure_routes(&block : Kemal::Router -> _)
      block.call(@@app.router)
    end
  end
end
