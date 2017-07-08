require "../spec_helper"

class MyApp < Kemal::Application
end

class OkController < Kemal::Controller
  def process
    "OK!"
  end
end

MyApp.configure_routes do |routes|
  routes.add "get", "/ok", OkController
end

describe "Application Layer" do
  it "routes to controller" do
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
