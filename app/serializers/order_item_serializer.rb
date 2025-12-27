class OrderItemSerializer < Blueprinter::Base
  identifier :id

  fields :quantity,
         :unit_price_cents,
         :total_price_cents

  association :product, blueprint: ProductSerializer
end
