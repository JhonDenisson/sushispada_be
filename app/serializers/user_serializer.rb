class UserSerializer < Blueprinter::Base
  identifier :id

  fields :name, :email

  view :admin do
    fields :role, :created_at
  end
end
