require 'rails_helper'

RSpec.describe Business::SessionsController, type: :controller do
  before {@request.env["devise.mapping"] = Devise.mappings[:user]}
  describe "GET #new" do
    it "render new template" do
      get :new
      expect(response).to render_template "business/sessions/new"
    end
  end

  describe "POST #create" do
    context "when a valid param" do
      let!(:valid_manager){FactoryBot.create :user, role: :manager}
      let!(:valid_employee){FactoryBot.create :user, role: :employee}
      let!(:valid_trainer){FactoryBot.create :user, role: :trainer}

      context "when a valid" do
        it "should redirect to business_home_path if user is employee" do
          post :create, params: {user: {email: valid_employee.email, password: Settings.password_default}}
          expect(response).to redirect_to business_home_path
        end

        it "should redirect to trainers_root_path if user is trainer" do
          post :create, params: {user: {email: valid_trainer.email, password: Settings.password_default}}
          expect(response).to redirect_to trainers_root_path
        end

        it "should redirect to managers_root_path if user is manager" do
          post :create, params: {user: {email: valid_manager.email, password: Settings.password_default}}
          expect(response).to redirect_to managers_root_path
        end
      end

      context "when a invalid user" do
        it "should flash alert" do
          post :create, params: {user: {email: valid_manager.email, password: "1"}}
          expect(flash[:alert].present?).to eq true
        end
      end
    end

    context "when a invalid param" do
      it "should flash alert" do
        post :create, params: {user: {email: nil, password: "1"}}
        expect(flash[:alert].present?).to eq true
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      user = FactoryBot.create :user
      sign_in user
    end
    it "should redirect to new_user_session_path" do
      delete :destroy
      expect(response).to redirect_to new_user_session_path
    end
  end
end
