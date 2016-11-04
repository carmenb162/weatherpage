require 'sinatra'
require 'httparty'

before do
  new_report =  HTTParty.get("https://query.yahooapis.com/v1/public/yql?q=select%20item.condition%20from%20weather.forecast%20where%20woeid%20%3D%202450080&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")


  @date_from_api = new_report['query']['results']['channel']['item']['condition']['date']

  @conditions_from_api = new_report['query']['results']['channel']['item']['condition']['text']

  @temp_from_api = new_report['query']['results']['channel']['item']['condition']['temp']


  # This puts stuff displays in the terminal only
  puts "*" * 50
  puts @date_from_api
  puts @conditions_from_api
  puts "#{@temp_from_api} F"
end


# This has to run AFTER the API, and actually tells the server to
# look at the HTML file 'weather'

get '/' do
  erb :'weather.html'
end
