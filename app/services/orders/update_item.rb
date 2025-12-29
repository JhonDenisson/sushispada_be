module Orders
  class UpdateItem
    def initialize(order_item:, quantity:)
      @order_item = order_item
      @quantity = quantity.to_i
    end

    def call
      raise "Order is not draft" unless @order_item.order.draft?
      raise "Invalid quantity" if @quantity <= 0

      OrderItem.transaction do
        @order_item.update!(quantity: @quantity)
        @order_item.order.recalculate_totals!
      end
    end
  end
end
