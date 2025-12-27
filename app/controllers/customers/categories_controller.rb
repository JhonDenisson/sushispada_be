module Customers
  class CategoriesController < ApplicationController
    def index
      categories = policy_scope(Category)
                     .order(:position)
                     .page(params[:page])
                     .per(params[:per_page] || 20)

      render json: {
        data: CategorySerializer.render_as_hash(categories),
        meta: {
          current_page: categories.current_page,
          total_pages: categories.total_pages,
          total_count: categories.total_count,
          per_page: categories.limit_value
        }
      }
    end
  end
end