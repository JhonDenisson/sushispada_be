class ProductSerializer < Blueprinter::Base
  identifier :id
  fields :name, :description, :price_cents, :active

  view :admin do
    fields :created_at, :updated_at
  end
end
