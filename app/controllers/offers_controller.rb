class OffersController < ApplicationController
	before_action { session[:vote_offers] ||= {} }
#	def index 
#		@offers = Offer.visible
#	end

	def offer
		if params[:offer] && params[:vote_option][:id]
			@offer = Offer.find(params[:offer][:id])
			@offers_option = @offer.vote_options.find(params[:vote_option][:id])
			if @offer && @offers_option && !session[:vote_offers][params[:vote_option][:id]]
				inc_vote_count
				add_cookies
				render 'offers/update'
			end
		end 
	end

	def create 
		@offer = Offer.new(params_offer)
		@offer.vote_options = craete_options
		if offer.save
			redirect_to offers_path, notice: "Offer was created"
		else
			render :new
		end 
	end

	private

	def params_offer
		params.require(:offer).permit(:topic)
	end

	def create_options
		return VoteOption.create(title: "Да"), VoteOption.create(title: "Нет")
	end

	def inc_vote_count
		@offers_option.votes_count += 1
		@offers_option.save!
	end

	def add_cookies
		session[:vote_offers][params[:offer][:id]] = {vote_options_id: params[:vote_option][:id]}
	end

end
