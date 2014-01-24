
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'yahoo_finance'
require 'dotenv'
require 'twitter'
require 'pg'

Dotenv.load
set :server, 'webrick'


#helps run sql commandss
def run_sql(sql)
	db = PG.connect(dbname: 'address_book', host: 'localhost')
	result = db.exec(sql)
	db.close
	result
end



get '/people' do
	@people = run_sql("SELECT * FROM PEOPLE")
	erb :people
end

post '/people' do
	#these need to some in from a form submission
	name = params[:name]
	phone = params[:phone]
	run_sql("INSERT INTO people (name, phone) VALUES ('#{name}','#{phone}')")
	redirect to '/people'
end

#creates a twitter client object
def twitter_client
		client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["CONSUMER_KEY"]
	  config.consumer_secret     = ENV["CONSUMER_SECRET"]
	  config.access_token        = ENV["ACCESS_TOKEN"]
	  config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
	end
end




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

get '/twitter/:username' do
	username = params[:username]
	@user = params[:username]
	@tweets = twitter_client.user_timeline(username)
	# tweets.each do |tweet|
	# 	tweet.text
	# end
	erb :tweets
end
