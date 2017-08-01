require "sinatra/base"
require "sinatra/json"

require_relative "radar"

class FlightSchool < Sinatra::Base
  get "/" do
    erb :index, locals: { airports: ["JFK", "SFO", "OHR", "FWA", "OAK", "SEA", "LAX"] }
  end

  get "/airports/:code" do
    begin
      airport_status = Radar.status_for(params[:code])
      erb :airport, locals: { status: airport_status }
    rescue Radar::NoSuchAirport
      status 404
      erb :no_airport
    end
  end

  get "/api/airports/:code" do
    begin
      airport_status = Radar.status_for(params[:code])
      json code: airport_status.code,
        name: airport_status.name,
        city: airport_status.city,
        weather: airport_status.weather
    rescue Radar::NoSuchAirport
      status 404
    end
  end
end
