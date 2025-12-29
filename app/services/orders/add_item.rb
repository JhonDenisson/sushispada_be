module Orders
  class AddItem
    def initialize(order:, product_id:, quantity:)
      @order = order
      @product = Product.find(product_id)
      @quantity = quantity.to_i
    end
    def call
      raise "Order is not draft" unless @order.draft?
      raise "Invalid quantity" if @quantity <= 0

      item = @order.order_items.find_by(product_id: @product.id)

      OrderItem.transaction do
        if item
          item.update!(quantity: item.quantity + @quantity)
        else
          @order.order_items.create!(
            product: @product,
            quantity: @quantity,
            unit_price_cents: @product.price_cents
          )
        end

        @order.recalculate_totals!
      end
    end
  end
end
