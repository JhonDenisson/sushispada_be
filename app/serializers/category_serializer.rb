class CategorySerializer < Blueprinter::Base
  identifier :id
  fields :name, :position, :active

  view :minimal do
    fields :id, :name
    excludes :position, :active
  end

  view :admin do
    fields :created_at, :updated_at
  end
end
