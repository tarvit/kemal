require "../spec_helper"

class MyApp < Kemal::Application
end

class OkAction < Kemal::Action
  def process
    "OK!"
  end
end

MyApp.configure_routes do |routes|
  routes.add "get", "/ok", OkAction
end

describe "Application Layer" do
  it "routes to Action" do
    request = HTTP::Request.new("GET", "/ok")
    client_response = call_request_on_app(request)
    client_response.body.should eq("OK!")
  end

  it "returns empty response when invalid path" do
    request = HTTP::Request.new("GET", "/")
    client_response = call_request_on_app(request)
    client_response.body.should eq("")
  end
end
