require "json"
require "net/http"
require "uri"

Status = Struct.new(:code, :name, :city, :weather)

class Radar
  class NoSuchAirport < RuntimeError; end

  def self.status_for(airport)
    uri = URI.parse("http://services.faa.gov/airport/status/#{airport}")
    req = Net::HTTP::Get.new(uri)
    req["Accept"] = "application/json"
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    raise NoSuchAirport if res.code == "404"

    decoded = JSON.parse(res.body)

    Status.new(
      decoded.fetch("IATA"),
      decoded.fetch("name"),
      decoded.fetch("city"),
      decoded.fetch("weather").fetch("weather"),
    )
  end
end
