class Admin::OffersController < Admin::AdminController
	before_action :find_offer, only: [:edit, :update, :destroy]
	
	def index
		@offers = Offer.all
	end

	def new
		@offer = Offer.new
	end

	def create
		@offer = Offer.new(params_offer)
		@offer.vote_options = create_options
		if @offer.save
			redirect_to admin_offers_path, notice: "Offer was created"
		else
			render :new		
		end
	end

	def edit
	end

	def update
		if @offer.update_attributes(params_offer)
			flash[:success] = "Updated"
			redirect_to admin_offers_path, notice: "Offer was updated" 
		else
			render :edit
		end
	end

	def destroy
		@offer.destroy
		redirect_to admin_offers_path
	end

	private

	def find_offer
		@offer = Offer.find(params[:id])
	end

	def params_offer
		params.require(:offer).permit(:topic, :image, :visible)
	end

	def create_options
		return VoteOption.create(title: "Да"), VoteOption.create(title: "Нет")
	end
end
