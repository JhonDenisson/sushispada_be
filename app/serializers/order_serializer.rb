class OrderSerializer < Blueprinter::Base
  identifier :id

  fields :status,
         :delivery_type,
         :payment_method,
         :subtotal_cents,
         :delivery_fee_cents,
         :discount_cents,
         :total_cents,
         :notes,
         :placed_at

  fields :delivery_street,
         :delivery_number,
         :delivery_complement,
         :delivery_neighborhood,
         :delivery_city,
         :delivery_reference

  association :order_items, blueprint: OrderItemSerializer

  view :admin do
    fields :created_at, :updated_at
    association :user, blueprint: UserSerializer
  end
end
