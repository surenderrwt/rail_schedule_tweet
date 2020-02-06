class TweetsController < ApplicationController
	before_action :set_tweet, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :have_twitter_account_setup, except: [:index]

	TWITTER_API_KEY = "vvFwBLPsGQLkpIVrjeL7yz6gP"
	TWITTER_API_SECRECT = "HbX8R07dhvEnEVozF7pd0TGDIwsEU4nPaXk5MLRA431bpREfYC"

	# GET /tweets
	# GET /tweets.json
	def index
		if current_user.is_admin?(current_user)
			@tweets = Tweet.all
		else
			@tweets = current_user.tweets
		end
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
		puts params[:post_now]
		if params[:post_now] == "1"
			client = Twitter::REST::Client.new do |config|
				config.consumer_key        = TWITTER_API_KEY
				config.consumer_secret     = TWITTER_API_SECRECT
				config.access_token        = current_user.access_token
				config.access_token_secret = current_user.access_token_secret
			end
			content = params[:tweet][:content]
		end
		@tweet = current_user.tweets.build(tweet_params)
		respond_to do |format|
			if @tweet.save
				if client.update("#{content}")
					puts @tweet.update(tweeted: true)
					flash[:notice] = "Successfully posted " 
				else
					flash[:notice] = "not updated " 
				end
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
		if current_user.access_token.nil? and current_user.is_admin?(current_user)
			redirect_to oauth_request_path
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def tweet_params
		params.require(:tweet).permit(:content, :send_at)
	end

	def send_now_params
		params.permit(:post_now)

	end
end
