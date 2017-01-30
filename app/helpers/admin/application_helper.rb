module Admin::ApplicationHelper
  def roles
    hash = {}

    Role.available_roles.each do |role|
      hash[role.titleize] = role
    end

    hash
  end

# This was substituted for the other example because if adds a new roles? then the other version is better
  # def roles
  #   {
  #     'Manager' => 'manager',
  #     'Editor'  => 'editor',
  #     'Viewer'  => 'viewer'
  #   }
  # end
end
