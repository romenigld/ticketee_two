require "rails_helper"

RSpec.feature "Users can only see the appropriate links" do
  let(:project) { create(:project) }
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:ticket) do
    create(:ticket, project: project, author: user)
  end

  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end
# Now anonymous users can’t even visit the project page, so this test can be safely deleted.
# Then I just commented this scenario for watch the example for the future sample, but considering was deleted.
    # scenario "cannot see the Delete Project link" do
    #   visit project_path(project)
    #   expect(page).not_to have_link "Delete Project"
    # end
  end

  context "non-admin users (project viewers)" do
    before do
      login_as(user)
      assign_role!(user, :viewer, project)
    end

    scenario "cannot see the New Project link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end

    scenario "cannot see the New Ticket link" do
      visit project_path(project)
      expect(page).not_to have_link "New Ticket"
    end

    scenario "cannot see the Edit Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link "Edit Ticket"
    end

    scenario "cannot see the Delete Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link "Delete Ticket"
    end

    scenario "cannot see the New Comment form" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_heading "New Comment"
    end
  end

  context "admin users" do
    before { login_as(admin) }

    scenario "can see the New Project link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end

    scenario "can see the Edit Project link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end

    scenario "can see the New Ticket link" do
      visit project_path(project)
      expect(page).to have_link "New Ticket"
    end

    scenario "can see the Edit Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link "Edit Ticket"
    end

    scenario "can see the Delete Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link "Delete Ticket"
    end

    scenario "can see the New Comment form" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_heading "New Comment"
    end
  end

end
