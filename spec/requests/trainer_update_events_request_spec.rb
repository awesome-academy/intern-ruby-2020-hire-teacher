require 'rails_helper'
require "cancan/matchers"

RSpec.describe Trainers::UpdateEventsController, type: :controller do
  include_examples "create example events"

  describe "when user not login" do
    context "PATCH #update" do
      before {patch :update, params: {locale: :vi, id: event3.id, format: :js}}

      it "redirect to new_user_session_path" do
        expect(response.body).to eq("Bạn cần đăng nhập hoặc đăng ký trước khi tiếp tục.")
      end

      it "should found" do
        expect(response).to have_http_status 401
      end
    end
  end

  describe "when user login not as trainer" do
    before {login account_employee}

    context "PATCH #update" do
      before {patch :update, params: {locale: :vi, id: event3.id, format: :js}}

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t "trainers.warning.not_correct"
      end

      it "should found" do
        expect(response).to have_http_status 302
      end
    end
  end

  describe "when user login as trainer" do
    before {login account_trainer}

    describe "PATCH #update" do
      context "with valid event_id" do
        before {patch :update, params: {locale: :vi, id: event3.id, format: :js}}

        it "should correct activated event" do
          expect(assigns(:event).status).to eq "activate"
        end

        it "response 200 with success: true" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid event_id" do
        before {patch :update, params: {locale: :vi, id: 100, format: :js}}

        it "should render warning flash" do
          expect(flash[:warning]).to eq I18n.t("managers.warning.show_room", id: 100)
        end

        it "redirect to trainers_root_path" do
          expect(response).to redirect_to trainers_root_path
        end
      end
    end
  end
end
