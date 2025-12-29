class OrderPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    owner? || user.admin?
  end

  def create?
    user.customer?
  end

  def checkout?
    owner? && record.draft?
  end

  private

  def owner?
    record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end