module Orders
  class RemoveItem
    def initialize(order_item:)
      @order_item = order_item
    end

    def call
      raise 'Order is not draft' unless @order_item.order.draft?

      OrderItem.transaction do
        order = @order_item.order
        @order_item.destroy!
        order.recalculate_totals!
      end
    end
  end
end
