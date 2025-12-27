module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: [ :show, :update, :destroy ]

    def index
      categories = policy_scope(Category)
                     .order(:position)
                     .page(params[:page])
                     .per(params[:per_page] || 20)

      render json: {
        data: CategorySerializer.render_as_hash(categories, view: :admin),
        meta: {
          current_page: categories.current_page,
          total_pages: categories.total_pages,
          total_count: categories.total_count,
          per_page: categories.limit_value
        }
      }
    end

    def show
      render json: CategorySerializer.render(@category)
    end

    def create
      category = Category.new(category_params)
      authorize category

      if category.save
        render json: CategorySerializer.render(category), status: :created
      else
        render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @category.update(category_params)
        render json: CategorySerializer.render(@category)
      else
        render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @category.destroy
      head :no_content
    end

    private

    def set_category
      @category = Category.find(params[:id])
      authorize @category
    end

    def category_params
      params.require(:category).permit(:name, :position)
    end
  end
end
