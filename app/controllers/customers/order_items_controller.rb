module Customers
  class OrderItemsController < ApplicationController
    def create
      order = Order.find(params[:order_id])

      item = OrderItem.new(order: order)
      authorize item

      Orders::AddItem.new(
        order: order,
        product_id: item_params[:product_id],
        quantity: item_params[:quantity]
      ).call

      head :no_content
    end

    def update
      item = OrderItem.find(params[:id])
      authorize item

      Orders::UpdateItem.new(
        order_item: item,
        quantity: item_params[:quantity]
      ).call

      head :no_content
    end

    def destroy
      item = OrderItem.find(params[:id])
      authorize item

      Orders::RemoveItem.new(order_item: item).call

      head :no_content
    end

    private

    def item_params
      params.require(:order_item).permit(:product_id, :quantity)
    end
  end
end
