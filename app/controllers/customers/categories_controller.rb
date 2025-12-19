module Customers
  class CategoriesController < ApplicationController
    def index
      categories = policy_scope(Category).order(:position)
      render json: CategorySerializer.render(categories)
    end
  end
end