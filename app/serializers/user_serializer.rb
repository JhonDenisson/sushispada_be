class UserSerializer < Blueprinter::Base
  identifier :id

  fields :name, :email, :role, :created_at
end
