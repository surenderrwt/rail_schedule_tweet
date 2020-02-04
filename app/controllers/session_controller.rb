class SessionController < ApplicationController
	before_action :authenticate_user!
  	@@callback_url = "http://localhost:3001/oauth/callback"
  	@@oauth_consumer = OAuth::Consumer.new("vvFwBLPsGQLkpIVrjeL7yz6gP", "HbX8R07dhvEnEVozF7pd0TGDIwsEU4nPaXk5MLRA431bpREfYC", :site => "https://twitter.com")
    	

  	def new
  		puts request_token = @@oauth_consumer.get_request_token(:oauth_callback => @@callback_url)
    	session[:oauth_consumer] = @@oauth_consumer
  		puts session[:token] = request_token.token
		puts session[:token_secret] = request_token.secret
		redirect_to request_token.authorize_url(:oauth_callback => @@callback_url)
   	end

    def create
    # 	callback_url = "http://localhost:3001/oauth/callback"
  		# puts oauth_consumer = OAuth::Consumer.new("vvFwBLPsGQLkpIVrjeL7yz6gP", "HbX8R07dhvEnEVozF7pd0TGDIwsEU4nPaXk5MLRA431bpREfYC", :site => "https://twitter.com")
    	hash = { oauth_token: session[:token], oauth_token_secret: session[:token_secret]}
    	puts hash
		puts request_token  = OAuth::RequestToken.from_hash(@@oauth_consumer, hash)
		# request_token = OAuth::RequestToken.new(oauth_consumer, session[:token],session[:token_secret])
		# puts access_token = request_token.get_access_token
		# For 3-legged authorization, flow oauth_verifier is passed as param in callback
		puts "access_token"
		@access_token = request_token.get_access_token(oauth_verifier: params[:oauth_verifier]) 
		puts @access_token.inspect
		current_user.update(access_token: @access_token.token, access_token_secret: @access_token.secret)

		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = "vvFwBLPsGQLkpIVrjeL7yz6gP"
		  config.consumer_secret     = "HbX8R07dhvEnEVozF7pd0TGDIwsEU4nPaXk5MLRA431bpREfYC"
		  config.access_token        = @access_token.token
		  config.access_token_secret = @access_token.secret
		end

			client.update("Amit is my best friend")

		@photos = @access_token.get('/photos.xml')
  		# if access_token
  		# 	redirect_to controller: "pages", action: "index"
  		# end
   	end

	def logout
		session.delete(current_user)
		reset_session
		session.clear
	end
end
