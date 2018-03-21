require 'rails_helper'
  feature "GET /sigin_in" do
    scenario "Registered user try sign in" do
      sigin_in
      expect(page).to have_content 'Список'
    end
end
