class OrdersController < ApplicationController

	def index #история заказов
		@orders = Order.where(user_id: params[:user_id])
		render json: @orders.as_json(include: [:order_items])
	end

	def new
		@order = Order.new
	end

	def create
		@order = Order.new(order_params)
		if @order.save
			redirect_to @order
		else 
			render :new
		end
	end

	def display
		@order = Order.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @order.as_json(include: :order_items) }
		end
		unless @order.user_id == params[:user_id].to_i
			redirect_to :user_orders # должно быть типа 404 not found
		end
	end

	def edit
	end

	def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
			redirect_to @order
		else
			render :new
		end
	end

	def destroy
		@order = Order.find(params[:id])
		if @order.paid
			raise "Already paid"
		else
			@order.destroy
		end
		redirect_to :orders
	end

	def pay
		@order = Order.find(params[:id])
		@order.pay!
		redirect_to :user_orders
	end

	def last
		@orders = Order.orders_for_last_period(params[:period].to_i)
		render json: @orders.as_json(include: :order_items)
	end

	private

	def order_params
		params.require(:order).permit(:adress, :user_id)
	end

end