require "rack/test"

ENV['RACK_ENV'] = 'test'

require "app"

RSpec.describe "The FlightSchool application" do
  include Rack::Test::Methods

  def app
    FlightSchool
  end

  it "says hello" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Hello world!")
  end
end
