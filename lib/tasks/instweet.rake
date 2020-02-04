require 'active_record'

namespace :instweet do
	desc "to send instent tweets"
	task :post_tweet => :environment do 
		puts remaining_tweets = Tweet.where("send_at < ? and tweeted = ?", Time.now, false)
		puts remaining_tweets.inspect
		
		remaining_tweets.each do |tweet|
			client = Twitter::REST::Client.new do |config|
			  config.consumer_key        = TWITTER_API_KEY
			  config.consumer_secret     = TWITTER_API_SECRECT
			  config.access_token        = tweet.user.access_token
			  config.access_token_secret = tweet.user.access_token_secret
			end
			if client.update(tweet.content)
				puts tweet.update(tweeted: true)
			end
		end
	end
end
