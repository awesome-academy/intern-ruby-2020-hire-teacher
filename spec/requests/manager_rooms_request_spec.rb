require 'rails_helper'
require "cancan/matchers"

RSpec.describe Managers::RoomsController, type: :controller do
  include_examples "create example rooms"

  let!(:location) {FactoryBot.create :location}
  let!(:current_user) {FactoryBot.create :user, role: :employee}
  let!(:current_manager) {FactoryBot.create :user, role: :manager, activated: true}
  let!(:manager_params) do
    FactoryBot.attributes_for :room,
      user_id: current_manager.id,
      location_id: location.id,
      name: "Demo room",
      address: Faker::Address.full_address
  end

  let!(:manager_invalid_params) do
    FactoryBot.attributes_for :room,
      user_id: current_manager.id,
      location_id: location.id,
      name: nil,
      address: Faker::Address.full_address
  end

  let!(:user_params) do
    FactoryBot.attributes_for :room,
    user_id: current_user.id,
    location_id: location.id,
    name: Faker::Company.name,
    address: Faker::Address.full_address
  end

  context "when user not login" do
    describe "GET #index" do
      before {get :index, params: {locale: :vi}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "GET #new" do
      before {get :new, params: {locale: :vi}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "POST #create" do
      before do
        post :create,
        params: {
          locale: :vi,
          room: user_params,
          image: FactoryBot.attributes_for(
            :image,
            room: room2
          )
        }
      end

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "GET #show" do
      before {get :show, params: {id: room2.id, locale: :vi}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "GET #edit" do
      before {get :edit, params: {id: room2.id, locale: :vi}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "PATCH #update" do
      before do
        patch :update, params: {
          locale: :vi,
          id: room2.id,
          name: Faker::Company.name
        }
      end

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "DELETE #destroy" do
      before{delete :destroy, params: {id: room3.id, locale: :vi}}

      it "redirect to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end
  end

  context "when user login not as manager" do
    before {login current_user}

    describe "GET #index" do
      before {get :index}

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end

    describe "GET #new" do
      before {get :new}

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end

    describe "POST #create" do
      before do
        post :create,
        params: {
          room: user_params,
          image: FactoryBot.attributes_for(
            :image,
            room: room2
          )
        }
      end

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end

    describe "GET #show" do
      before {get :show, params: {id: room2.id}}

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end

    describe "GET #edit" do
      before {get :edit, params: {id: room2.id}}

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end

    describe "PATCH #update" do
      before do
        patch :update, params: {
          id: room2.id,
          name: Faker::Company.name
        }
      end

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end

    describe "DELETE #destroy" do
      before{delete :destroy, params: {id: room3.id}}

      it "should render warning flash" do
        expect(flash[:warning]).to eq I18n.t("cancancan.warning.access_denied")
      end

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_home_path
      end
    end
  end

  context "when user login as manager" do
    before {login current_manager}

    describe "GET #index" do
      context "when no params" do
        before {get :index}

        it "list all rooms" do
          expect(assigns(:rooms)).to eq([room3, room2, moscow])
        end

        it "render the index view" do
          expect(response).to render_template :index
        end
      end

      context "when have some params" do
        before do
          get :index, params: {
            q: {
              created_on_eq: Time.zone.today,
              name_cont: Settings.rspec.room_controller.params_name
            }
          }
        end

        it "list filter rooms" do
          expect(assigns(:rooms)).to eq([moscow])
        end

        it "render the index view" do
          expect(response).to render_template :index
        end
      end
    end

    describe "GET #new" do
      before {get :new}

      it "assigns a new Room to @room" do
        expect(assigns(:room)).to be_a_new(Room)
      end

      it "render the new view" do
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with invalid attributes" do
        before {post :create, params: {room: manager_invalid_params}}

        it "create a new room fail" do
          expect{
            post :create, params: {room: manager_invalid_params}
          }.to change(Room, :count).by(0)
        end

        it "should render danger flash" do
          expect(flash[:danger]).to eq I18n.t("managers.danger.create_room")
        end

        it "should render new" do
          expect(response).to render_template "managers/rooms/new"
        end
      end

      context "with valid attributes" do
        before {post :create, params: {room: manager_params}}

        it "create a new room success" do
          should be_able_to(:create, params: {room: manager_params})
        end

        it "should render success flash" do
          expect(flash[:success]).to eq I18n.t("managers.success.create_room", name: "Demo room")
        end

        it "should redirect to managers room path" do
          expect(response).to redirect_to managers_room_path(Room.last)
        end
      end
    end

    describe "GET #show" do
      context "with valid attributes" do
        before {get :show, params: {id: room2.id}}

        it "assigns all events in room to @events" do
          expect(assigns(:events)).to eq []
        end

        it "render view show template" do
          expect(response).to render_template :show
        end
      end

      context "with invalid attributes" do
        before {get :show, params: {id: Settings.rspec.room_controller.invalid_id}}

        it "should render warning flash" do
          expect(flash[:warning]).to eq I18n.t("managers.warning.show_room",
            id: Settings.rspec.room_controller.invalid_id)
        end

        it "redirect to managers rooms path" do
          expect(response).to redirect_to managers_rooms_path
        end
      end
    end

    describe "GET #edit" do
      context "with valid room_id" do
        before {get :edit, params: {id: room2.id}}

        it "render view edit template" do
          expect(response).to render_template :edit
        end
      end

      context "with invalid room_id" do
        before {get :edit, params: {id: Settings.rspec.room_controller.invalid_id}}

        it "should render warning flash" do
          expect(flash[:warning]).to eq I18n.t("managers.warning.show_room",
            id: Settings.rspec.room_controller.invalid_id)
        end

        it "redirect to managers rooms path" do
          expect(response).to redirect_to managers_rooms_path
        end
      end
    end

    describe "PATCH #update" do
      context "with valid room_id" do
        before do
          patch :update, params: {
            id: room2.id,
            room: FactoryBot.attributes_for(
              :room,
              id: room2.id,
              name: Settings.rspec.room_controller.room_name
            )
          }
        end

        it "should render success flash" do
          expect(flash[:success]).to eq I18n.t("managers.success.update_room",
            name: Settings.rspec.room_controller.room_name)
        end

        it "redirect to managers room path" do
          expect(response).to redirect_to managers_room_path room2
        end
      end

      context "with invalid room_id" do
        before do
          patch :update, params: {
            id: room2.id,
            room: FactoryBot.attributes_for(
              :room,
              id: room2.id,
              name: nil
            )
          }
        end

        it "should render danger flash" do
          expect(flash[:danger]).to eq I18n.t("managers.danger.update_room")
        end

        it "render edit template" do
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      context "when destroy success" do
        before{delete :destroy, params: {id: room3.id, format: :js}}

        it "should render @status = 1" do
          expect(assigns(:status)).to eq 1
        end

        it "response to success status 200" do
          expect(response.status).to eq 200
        end
      end
    end
  end
end
