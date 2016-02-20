require 'sinatra/base'

class FlightSchool < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
