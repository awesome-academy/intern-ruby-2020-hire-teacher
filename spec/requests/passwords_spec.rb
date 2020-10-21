require 'rails_helper'

RSpec.describe Business::PasswordsController, type: :controller do
  before {@request.env["devise.mapping"] = Devise.mappings[:user]}

  describe "GET #new" do
    it "render new template" do
      get :new
      expect(response).to render_template "business/passwords/new"
    end
  end
end
