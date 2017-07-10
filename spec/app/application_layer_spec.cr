require "../spec_helper"

class MyApp < Kemal::Application
end

class OkAction < Kemal::Action
  def process
    "OK!"
  end
end

describe "Application Layer" do
  MyApp.configure_routes do |routes|
    routes.add "get", "/ok", OkAction
  end

  it "routes to Action" do
    request = HTTP::Request.new("GET", "/ok")
    client_response = call_request_on_app(request)
    client_response.body.should eq("OK!")
  end

  it "returns 404 code when invalid path" do
    error_404_is_not_set = !Kemal.config.error_handlers.has_key?(404)

    Kemal.config.add_error_handler(404) { |env| render_404 } if error_404_is_not_set

    request = HTTP::Request.new("GET", "/not_ok")
    client_response = call_request_on_app(request)
    client_response.status_code.should eq(404)

    Kemal.config.remove_error_handler(404) if error_404_is_not_set
  end
end
