require "webmock/rspec"

require "radar"

RSpec.describe Radar, ".status_for" do
  context "when the airport can be found" do
    before do
      stub_request(:get, "http://services.faa.gov/airport/status/JFK").
        with(:headers => {"Accept" => "application/json"}).
        to_return(File.new(fixture("jfk")))
    end

    subject(:status) do
      Radar.status_for("JFK")
    end

    it "has a IATA code" do
      expect(status.code).to eq("JFK")
    end

    it "has a name" do
      expect(status.name).to eq("John F Kennedy International")
    end

    it "has a city" do
      expect(status.city).to eq("New York")
    end

    it "has weather" do
      expect(status.weather).to eq("Overcast")
    end
  end

  context "when the airport cannot be found" do
    before do
      stub_request(:get, "http://services.faa.gov/airport/status/EDI").
        with(:headers => {"Accept" => "application/json"}).
        to_return(File.new(fixture("edi")))
    end

    it "raises an exception" do
      expect {
        Radar.status_for("EDI")
      }.to raise_error Radar::NoSuchAirport
    end
  end
end
