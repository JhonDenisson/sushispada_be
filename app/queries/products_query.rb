class ProductsQuery
  def initialize (scope, params)
    @scope = scope
    @params = params
  end

  def call
    filter_by_active
    filter_by_category
    @scope
  end

  private

  def filter_by_active
    return if @params[:active].blank?
    @scope = @scope.active
  end

  def filter_by_category
    return if @params[:category_id].blank?
    @scope = @scope.category(@params[:category_id])
  end
end
