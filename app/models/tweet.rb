class Tweet < ApplicationRecord
	belongs_to :user
	scope :get_tweets_without_user_id, -> { where("send_at < ? and tweeted = ?", Time.now, false) }
end
