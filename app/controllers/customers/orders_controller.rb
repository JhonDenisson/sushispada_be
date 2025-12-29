module Customers
  class OrdersController < ApplicationController
    def create
      order = Orders::FindOrCreateDraft.new(user: current_user).call
      authorize order
      render json: OrderSerializer.render(order), status: :created
    end

    def show
      order = Order.find(params[:id])
      authorize order
      render json: OrderSerializer.render(order)
    end

    def checkout
      order = Order.find(params[:id])
      authorize order

      Orders::Checkout.new(order: order, params: checkout_params).call

      head :no_content
    end

    private

    def checkout_params
      params.require(:order).permit(:delivery_type, :address_id, :payment_method)
    end
  end
end
