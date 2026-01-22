module Customers
  class ProductsController < ApplicationController
    def index
      products = ProductsQuery.new(policy_scope(Product).includes(:category), params).call
                              .order(:created_at)
                              .page(params[:page])
                              .per(params[:per_page] || 20)

      render json: {
        data: ProductSerializer.render_as_hash(products),
        meta: {
          current_page: products.current_page,
          total_pages: products.total_pages,
          total_count: products.total_count,
          per_page: products.limit_value
        }
      }
    end

    def show
      product = Product.find(params[:id])
      authorize product
      render json: ProductSerializer.render(product)
    end
  end
end
