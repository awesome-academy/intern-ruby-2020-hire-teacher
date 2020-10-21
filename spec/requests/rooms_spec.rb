require 'rails_helper'

RSpec.describe Business::RoomsController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: 2}

  context "when user not login" do
    describe "GET #index" do
      before {get :index, params: {locale: :vi}}
      it "should have_http_status 302" do
        expect(response).to have_http_status 302
      end

      it "should redirect new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #show" do
      before{get :show, params: {id: 1, locale: :vi}}
      it "should have_http_status 302" do
        expect(response).to have_http_status 302
      end

      it "redirect_to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when user login" do
    before {login user}

    describe "GET #index" do
      before {get :index, params: {locale: :vi}}
      it "should have_http_status 200" do
        expect(response).to have_http_status 200
      end

      it "should render index template" do
        expect(response).to render_template "business/rooms/index"
      end
    end

    describe "GET #show" do
      before{get :show, params: {id: 1, locale: :vi}}
      it "should have_http_status 200" do
        expect(response).to have_http_status 200
      end

      it "should render show template" do
        expect(response).to render_template "business/rooms/index"
      end
    end
  end
end
