class OrdersQuery
  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    filter_by_status
    filter_by_drafts
    filter_by_delivery_type
    filter_by_payment_method
    @scope
  end

  private

  def filter_by_status
    return if @params[:status].blank?
    @scope = @scope.status(@params[:status])
  end

  def filter_by_drafts
    return unless @params[:drafts].present?
    @scope = @scope.drafts
  end

  def filter_by_delivery_type
    return if @params[:delivery_type].blank?
    @scope = @scope.delivery_type(@params[:delivery_type])
  end

  def filter_by_payment_method
    return if @params[:payment_method].blank?
    @scope = @scope.payment_method(@params[:payment_method])
  end
end
