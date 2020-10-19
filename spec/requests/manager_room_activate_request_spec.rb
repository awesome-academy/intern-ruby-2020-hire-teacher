require 'rails_helper'
require "cancan/matchers"

RSpec.describe Managers::RoomActivesController, type: :controller do
  include_examples "create example rooms"

  describe "when user not login" do
    context "PATCH #update" do
      before do
        patch :update, params: {
          locale: :vi,
          id: moscow.id,
          format: :js
        }
      end

      it "redirect to new_user_session_path" do
        expect(response.body).to eq("Bạn cần đăng nhập hoặc đăng ký trước khi tiếp tục.")
      end

      it "should found" do
        expect(response).to have_http_status 401
      end
    end
  end

  describe "when user login not as manager" do
    before {login account_employee}

    context "PATCH #update" do
      before do
        patch :update, params: {
          locale: :vi,
          id: moscow.id,
          format: :js
        }
      end

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to business_home_path
      end

      it "should found" do
        expect(response).to have_http_status 302
      end
    end
  end

  describe "when user login as manager" do
    before {login account_manager}

    describe "PATCH #update" do
      context "with valid room_id" do
        before {patch :update, params: {locale: :vi, id: moscow.id, format: :js}}

        it "should correct activated user" do
          expect(assigns(:room).active).to eq "locked"
        end

        it "response 200 with success: true" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid room_id" do
        before {patch :update, params: {locale: :vi, id: 100, format: :js}}

        it "should render warning flash" do
          expect(flash[:warning]).to eq I18n.t("managers.warning.show_room", id: 100)
        end

        it "redirect to managers_users_path" do
          expect(response).to redirect_to managers_rooms_path
        end
      end
    end
  end
end
