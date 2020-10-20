require 'rails_helper'
require "cancan/matchers"

RSpec.describe Managers::EventsController, type: :controller do
  include_examples "create example events"

  describe "when user not login" do
    context "GET #index" do
      before {get :index, params: {locale: :vi}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end
  end

  describe "when user login not as manager" do
    before {login account_trainee}

    context "GET #index" do
      before {get :index, params: {locale: :vi}}

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end
  end

  describe "when user login as manager" do
    before {login account_manager}

    context "when no params" do
      before {get :index}

      it "list all users" do
        expect(assigns(:events).count).to eq(Event.count)
      end

      it "render the index view" do
        expect(response).to render_template :index
      end
    end

    context "when have some params" do
      before {get :index, params: {locale: :vi, search: "1", option: "title_cont"}}

      it "list filter users" do
        expect(assigns(:events)).to eq [event1]
      end

      it "render the index view" do
        expect(response).to render_template :index
      end
    end
  end
end
