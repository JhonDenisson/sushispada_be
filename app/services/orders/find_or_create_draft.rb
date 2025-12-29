module Orders
  class FindOrCreateDraft
    def initialize(user:)
      @user = user
    end
    def call
      Order.find_or_create_by!(user: @user, status: :draft)
    end
  end
end
