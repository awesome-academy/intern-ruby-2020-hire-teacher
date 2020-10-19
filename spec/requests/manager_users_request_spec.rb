require 'rails_helper'
require "cancan/matchers"

RSpec.describe Managers::UsersController, type: :controller do
  include_examples "create example users"

  describe "when user not login" do
    context "GET #index" do
      before {get :index, params: {locale: :vi, q: {name_cont: "man"}}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    context "PATCH #update" do
      before do
        patch :update, params: {
          locale: :vi,
          id: account_employee.id,
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

    context "GET #index" do
      before {get :index, params: {locale: :vi, q: {name_cont: "man"}}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to business_home_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    context "PATCH #update" do
      before do
        patch :update, params: {
          locale: :vi,
          id: account_employee.id,
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

    describe "GET #index" do
      context "when no params" do
        before {get :index}

        it "list all users" do
          expect(assigns(:users).count).to eq(User.count)
        end

        it "render the index view" do
          expect(response).to render_template :index
        end
      end

      context "when have some params" do
        before {get :index, params: {locale: :vi, q: {name_cont: "Train"}}}

        it "list filter users" do
          expect(assigns(:users)).to eq [account_trainee, account_trainer]
        end

        it "render the index view" do
          expect(response).to render_template :index
        end
      end
    end

    describe "PATCH #update" do
      context "with valid user_id" do
        before {patch :update, params: {locale: :vi, id: account_employee.id, format: :js}}

        it "should correct activated user" do
          expect(assigns(:user).activated).to eq !account_employee.activated
        end

        it "response 200 with success: true" do
          expect(response.status).to eq 200
        end
      end

      context "with invalid user_id" do
        before {patch :update, params: {locale: :vi, id: 100, format: :js}}

        it "should render warning flash" do
          expect(flash[:warning]).to eq I18n.t "managers.warning.is_manager"
        end

        it "redirect to managers_users_path" do
          expect(response).to redirect_to managers_users_path
        end
      end
    end
  end
end
