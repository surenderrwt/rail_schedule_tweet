class TweetsController < ApplicationController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :have_twitter_account_setup

	# GET /tweets
	# GET /tweets.json
	def index
		@tweets = current_user.tweets
		#@friends = CLIENT.friends(@surenderrwt, count: 3)
	end

	# GET /tweets/1
	# GET /tweets/1.json
	def show
	end

	# GET /tweets/new
	def new
		@tweet = Tweet.new
	end

	# GET /tweets/1/edit
	def edit
	end

	# POST /tweets
	# POST /tweets.json
	def create
		if params[:tweet][:post_now] == 1
			client = Twitter::REST::Client.new do |config|
				config.consumer_key        = TWITTER_API_KEY
				config.consumer_secret     = TWITTER_API_SECRECT
				config.access_token        = current_user.access_token
				config.access_token_secret = current_user.access_token_secret
			end
			client.update(params[:tweet][:content])
		end

		tweet_time = t = DateTime.new(params[:tweet]["send_at(1i)"].to_i,params[:tweet]["send_at(2i)"].to_i, params[:tweet]["send_at(3i)"].to_i, params[:tweet]["send_at(4i)"].to_i,params[:tweet]["send_at(5i)"].to_i)

		@tweet = current_user.tweets.build(content: params[:tweet][:content], send_at: tweet_time )
		respond_to do |format|
			if @tweet.save
				format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
				format.json { render :show, status: :created, location: @tweet }
			else
				format.html { render :new }
				format.json { render json: @tweet.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /tweets/1
	# PATCH/PUT /tweets/1.json
	def update
		respond_to do |format|
			if @tweet.update(tweet_params)
				format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
				format.json { render :show, status: :ok, location: @tweet }
			else
				format.html { render :edit }
				format.json { render json: @tweet.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /tweets/1
	# DELETE /tweets/1.json
	def destroy
		@tweet.destroy
		respond_to do |format|
			format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
			format.json { head :no_content }
		end
	end
	
	private
	# Use callbacks to share common setup or constraints between actions.
	def set_tweet
		@tweet = Tweet.find(params[:id])
	end

	def have_twitter_account_setup
		if current_user.access_token.nil?
			redirect_to oauth_request_path
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def tweet_params
		params.require(:tweet).permit(:content,:post_now, :send_at)
	end
end
