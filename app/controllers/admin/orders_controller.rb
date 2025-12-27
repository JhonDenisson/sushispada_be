module Admin
  class OrdersController < ApplicationController
    before_action :set_order, only: [ :show ]

    def index
      orders = OrdersQuery.new(policy_scope(Order), params).call
                              .order(:created_at)
                              .page(params[:page])
                              .per(params[:per_page] || 20)


      render json: {
        data: OrderSerializer.render_as_hash(orders),
        meta: {
          current_page: orders.current_page,
          total_pages: orders.total_pages,
          total_count: orders.total_count,
          per_page: orders.limit_value
        }
      }
    end

    def show
      render json: OrderSerializer.render(@order)
    end

    private

    def set_order
      @order = Order.find(params[:id])
      authorize @order
    end

    def order_params
      params.require(:order).permit(:delivery_type, :address_id, :payment_method)
    end
  end
end

