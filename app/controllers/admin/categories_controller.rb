module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]

    def index
      categories = policy_scope(Category).order(:position)
      render json: CategorySerializer.render(categories, view: :admin)
    end

    def show
      render json: CategorySerializer.render(@category)
    end

    def create
      return render json: { error: 'Category parameters are required' }, status: :bad_request if category_params.blank?
      
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
      params.require(:category).permit(:name, :position, :active)
    end
  end
end