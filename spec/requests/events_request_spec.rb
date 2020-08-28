require "rails_helper"

RSpec.describe Business::EventsController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:room) {FactoryBot.create :room}
  let!(:event) {FactoryBot.create :event, user_id: user.id, room_id: room.id}
  let!(:valid_params) do
    FactoryBot.attributes_for :event,
      user_id: user.id, room_id: room.id,
      date_event: Settings.rspec.create.valid_date_params
  end
  let!(:invalid_params) {FactoryBot.attributes_for :event, user_id: user.id, room_id: room.id, title: nil}

  context "when user not login" do
    describe "POST #create" do
      before {post :create, params: {event: valid_params}}

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_login_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "GET #edit" do
      before {get :edit, params: {id: event.id}}

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_login_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "PATCH #update" do
      before {
        patch :update, params: {
          id: event.id,
          event: {
            title: "test",
            date_event: Settings.rspec.update.valid_date,
            room_id: event.room_id
          }
        }
      }

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_login_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end

    describe "DELETE #destroy" do
      before{delete :destroy, params: {id: event.id}}

      it "redirect to business_home_path" do
        expect(response).to redirect_to business_login_path
      end

      it "should found" do
        expect(response).to have_http_status Settings.rspec.redirect_status
      end
    end
  end

  context "when user login" do
    before {login user}

    describe "POST #create" do
      context "with valid attributes" do
        before {post :create, params: {event: valid_params}}
        let(:event_success) do
          FactoryBot.attributes_for :event, user_id: user.id,
            room_id: room.id, date_event: Settings.rspec.create.valid_date
        end

        it "create a new event success" do
          expect{
            post :create, params: {event: event_success}
          }.to change(Event, :count).by(1)
        end

        it "redirect to business_room_path" do
          expect(response).to redirect_to business_room_path(id: valid_params[:room_id],
            day: valid_params[:date_event])
        end

        it "flash success" do
          expect(flash[:success]).to match I18n.t("controller.events.success_create")
        end
      end

      context "with invalid attributes" do
        before {post :create, params: {event: invalid_params}}

        it "create a new event fail" do
          expect{subject}.to change(Event, :count).by(0)
        end

        it "render template room" do
          expect(response).to render_template "business/rooms/show"
        end

        it "create a new event fail" do
          expect(flash[:error]).to match I18n.t("controller.events.error_create")
        end
      end
    end

    describe "GET #edit" do
      context "with valid event" do
        before{get :edit, params: {id: event.id}}

        it "find event & render view edit template" do
          expect(response).to render_template "business/events/edit"
        end
      end

      context "with invalid event" do
        before{get :edit, params: {id: "asdasd"}}

        it "not find event & redirect to business_home_path" do
          expect(response).to redirect_to business_home_path
        end

        it "flash error" do
          expect(flash[:error]).to match I18n.t("controller.events.error_load_event")
        end
      end
    end

    describe "PATCH #update" do
      before {
        patch :update, params: {
          id: event.id,
          event: {
            title: "test",
            date_event: Settings.rspec.update.valid_date,
            room_id: event.room_id
          }
        }
      }
      context "with valid attributes" do
        it "flash success" do
          expect(flash[:success]).to match(I18n.t("controller.events.success_update"))
        end

        it "redirect business_room_path" do
          expect(response).to redirect_to business_room_path(id: event.room_id, day: "2020-09-16")
        end
      end

      context "with invalid attributes" do
        before {
          patch :update, params: {
            id: event.id,
            event: {
              date_event: Settings.rspec.update.invalid_date,
              room_id: event.room_id
            }
          }
        }
        it "update error" do
          expect(flash[:error]).to match I18n.t("controller.events.error_update")
        end

        it "render template" do
          expect(response).to redirect_to business_room_path event.room_id
        end
      end
    end

    describe "DELETE #destroy" do
      context "with valid product" do
        let!(:event_destroy) do
          FactoryBot.create :event, user_id: user.id,
            room_id: room.id, date_event: Settings.rspec.create.valid_date
        end
        before{delete :destroy, params: {id: event.id}}

        it "delete success" do
          expect{
          delete :destroy, params: {id: event_destroy.id}
            }.to change(Event, :count).by(-1)
        end

        it "show flash message" do
          expect(flash[:success]).to match I18n.t("controller.events.success_destroy")
        end
      end

      context "with invalid product" do
        before{delete :destroy, params: {id: 1}}

        it "delete fail" do
          expect{subject}.to change(Event, :count).by(0)
        end

        it "show flash message" do
          expect(flash[:error]).to match I18n.t("controller.events.error_load_event")
        end
      end
    end
  end
end
