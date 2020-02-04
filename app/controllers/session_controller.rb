class SessionController < ApplicationController
	before_action :authenticate_user!
  	# @@callback_url = "http://localhost:3001/oauth/callback"
  	# @@oauth_consumer = OAuth::Consumer.new("vvFwBLPsGQLkpIVrjeL7yz6gP", "HbX8R07dhvEnEVozF7pd0TGDIwsEU4nPaXk5MLRA431bpREfYC", :site => "https://twitter.com")
    
    TWITTER_API_KEY = "vvFwBLPsGQLkpIVrjeL7yz6gP"
	TWITTER_API_SECRECT = "HbX8R07dhvEnEVozF7pd0TGDIwsEU4nPaXk5MLRA431bpREfYC"

	CALLBACK_URL = "https://instweet.herokuapp.com/oauth/callback"
	OAUTH_CONSUMER = OAuth::Consumer.new(TWITTER_API_KEY, TWITTER_API_SECRECT, :site => "https://twitter.com")

  	def new
  		puts request_token = OAUTH_CONSUMER.get_request_token(:oauth_callback => CALLBACK_URL)
  		puts session[:token] = request_token.token
		puts session[:token_secret] = request_token.secret
		redirect_to request_token.authorize_url(:oauth_callback => CALLBACK_URL)
   	end

    def create
    	hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    	puts hash
		puts request_token  = OAuth::RequestToken.from_hash(OAUTH_CONSUMER, hash)
		puts "access_token"
		@access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier]) 
		puts @access_token.inspect
		if current_user.update(access_token: @access_token.token, access_token_secret: @access_token.secret)
   			redirect_to controller: "tweets", action: "new", notice: 'successfully saved.'
   		else
   			redirect_to action: "new", notice: 'failure.'
   		end
   	end

	def logout
		# session.delete(current_user)
		reset_session
		# session.clear
	end
end
