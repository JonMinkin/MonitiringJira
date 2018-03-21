require 'rails_helper'
describe ErrorsController do
  it "renders error_404 view" do
    get :error_404
    expect(response).to render_template :error_404
  end
end
