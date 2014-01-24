require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoo_finance'

get '/' do


	ticker = params[:ticker]
	quotes = YahooFinance.quotes([ticker], [:ask, :bid, :last_trade_date, :average_daily_volume])
	@ticker = ticker
	@ask = quotes[0].ask
	@bid = quotes[0].bid
	@date = quotes[0].last_trade_date
	@adv = quotes[0].average_daily_volume

  erb :quote
end
