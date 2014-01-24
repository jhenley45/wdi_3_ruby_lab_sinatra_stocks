require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'

get '/quote/:ticker' do

	@ticker = params[:ticker]

  erb :quote
end
