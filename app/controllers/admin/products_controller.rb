module Admin
  class ProductsController < ApplicationController
    before_action :set_product, only: [ :show, :update, :destroy ]

    def index
      products = ProductsQuery.new(policy_scope(Product), params).call
                              .order(:created_at)
                              .page(params[:page])
                              .per(params[:per_page] || 20)


      render json: {
        data: ProductSerializer.render_as_hash(products, view: :admin),
        meta: {
          current_page: products.current_page,
          total_pages: products.total_pages,
          total_count: products.total_count,
          per_page: products.limit_value
        }
      }
    end

    def show
      render json: ProductSerializer.render(@product)
    end

    def create
      product = Product.new(product_params)
      authorize product

      if product.save
        render json: ProductSerializer.render(product), status: :created
      else
        render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(category_params)
        render json: CategorySerializer.render(@product)
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      head :no_content
    end

    private

    def set_product
      @product = Product.find(params[:id])
      authorize @product
    end

    def product_params
      params.require(:product).permit(:name, :description, :price_cents, :category_id)
    end
  end
end
