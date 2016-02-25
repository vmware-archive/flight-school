require "rack/test"

ENV['RACK_ENV'] = 'test'

require "app"

RSpec.describe "The FlightSchool application" do
  include Rack::Test::Methods

  def app
    FlightSchool
  end

  before do
    WebMock.allow_net_connect!
  end

  after do
    WebMock.disable_net_connect!
  end

  it "shows a list of common airports" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to include("Current status of airports")
  end

  it "shows facts about a particular airport" do
    get "/airports/SFO"
    expect(last_response).to be_ok
    expect(last_response.body).to include("San Francisco")
  end

  it "returns a 404 if the airport cannot be found" do
    get "/airports/EDI"
    expect(last_response).to be_not_found
    expect(last_response.body).to include("Couldn't find that airport!")
  end
end
