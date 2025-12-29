module Orders
  class Checkout
    def initialize(order:, params:)
      @order = order
      @params = params
    end
    def call
      raise "Order is not draft" unless @order.draft?
      Order.transaction do
        apply_delivery!
        apply_payment!
        finalize_order!
      end
    end

    private

    def apply_delivery!
      if @params[:delivery_type] == "delivery"
        address = Address.find(@params[:address_id])
        zone = DeliveryZone.find_by!(neighborhood: address.neighborhood)

        @order.delivery_type = :delivery_type
        @order.address = address
        @order.delivery_fee_cents = zone.delivery_fee_cents
      else
        @order.delivery_type = :pickup
        @order.delivery_fee_cents = 0
      end
    end

    def apply_payment!
      @order.payment_method = @params[:payment_method]
    end

    def finalize_order!
      @order.placed_at = Time.current
      @order.status = :placed
      @order.recalculate_totals!
    end
  end
end
