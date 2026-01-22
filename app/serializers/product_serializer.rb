class ProductSerializer < Blueprinter::Base
  identifier :id
  fields :name, :description, :price_cents, :active

  association :category, blueprint: CategorySerializer, view: :minimal

  view :admin do
    fields :created_at, :updated_at
  end
end
