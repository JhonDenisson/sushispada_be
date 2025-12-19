class CategorySerializer < Blueprinter::Base
  identifier :id
  fields :name, :position, :active

  view :admin do
    fields :created_at, :updated_at
  end
end