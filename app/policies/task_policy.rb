class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

    def create?
      true
    end

    def show?
      true
    end

    def new?
      true
    end

    def update?
      true
    end

    def index?
      true
    end

    def destroy?
      true
    end

    def mark_as_done?
      true
    end
end
