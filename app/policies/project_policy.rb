class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
  # none is a convenience method provided by Active Record to automatically return no records
      return scope.none if user.nil?
      return scope.all if user.admin?

      scope.joins(:roles).where(roles: { user_id: user })
    end
  end

  def show?
    user.try(:admin?) || record.has_member?(user)
  end

  def update?
    user.try(:admin?) || record.has_manager?(user)
  end
end
