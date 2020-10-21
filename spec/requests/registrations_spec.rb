require 'rails_helper'

RSpec.describe Business::RegistrationsController, type: :controller do
  before {@request.env["devise.mapping"] = Devise.mappings[:user]}

  describe "GET #new" do
    it "render new template" do
      get :new
      expect(response).to render_template "business/registrations/new"
    end
  end

  describe "POST #create" do
    context "when a valid" do
      let(:group) {FactoryBot.create :group}
      it "should redirect to business_home_path if user sign up success" do
        post :create, params: {
          user: {
            name: "hasdhasjdl",
            email: "nguyenss@hoang.anh",
            group_id: group.id,
            password: "Ho@nganh1",
            password_confirmation: "Ho@nganh1",
            role: :employee
          }
        }
        expect(response).to redirect_to business_home_path
      end
    end

    context "when a invalid" do
      it "should redirect to business_home_path if user sign up error" do
        post :create, params: {user: {email: nil}}
        expect(response).to render_template "business/registrations/new"
      end
    end
  end
end
