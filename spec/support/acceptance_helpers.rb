require 'spec_helper'
include Warden::Test::Helpers
module AcceptanceHelper
  def sigin_in
  	user = create(:user)
  	visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in "user_password", with: user.password
    click_on "ВОЙТИ"
  end
end