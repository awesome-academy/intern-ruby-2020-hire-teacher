require 'rails_helper'

RSpec.describe Business::ReportsController, type: :controller do
  let!(:employee) {FactoryBot.create :user, role: 2}
  let!(:room) {FactoryBot.create :room}

  context "when employee not login" do
    describe "POST #create" do
      before {post :create,
        params: {
          room_id: room.id,
          report: {
            parent_id: nil,
            room_id: room.id,
            user_id: employee.id,
            comment: "asd"
            },
            locale: "vi"
          }
        }
      it "redirect to business_home_path" do
        expect{subject}.to change(Report, :count).by(0)
      end

      it "should have_http_status 302" do
        expect(response).to have_http_status 302
      end

      it "should redirect new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      before{delete :destroy, params: {room_id: room.id, id: 2, locale: "vi"}}

      it "redirect to business_home_path" do
        expect{subject}.to change(Report, :count).by(0)
      end

      it "should have_http_status 302" do
        expect(response).to have_http_status 302
      end

      it "redirect_to new_user_session_path" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context "when employee login" do
    let(:report) {FactoryBot.create :report, user_id: employee.id, room_id: room.id, comment: "asd"}
    before {login employee}
    describe "POST #create" do
      context "when valid report" do
        before {
                post :create,
                  params: {
                    room_id: room.id,
                    report: {
                      parent_id: nil,
                      room_id: room.id,
                      user_id: employee.id,
                      comment: "test",
                    },
                    locale: :vi
                  }
                }
        let(:valid_report) do
          FactoryBot.attributes_for :report, user_id: employee.id,
            room_id: room.id, comment: "test", parent_id: nil
        end
        it "redirect to business_home_path" do
          expect{
            post :create, params: {room_id: room.id, report: valid_report}
          }.to change(Report, :count).by(1)
        end

        it "should found" do
          expect(response).to have_http_status Settings.rspec.redirect_status
        end

        it "should redirect new_user_session_path" do
          expect(response).to redirect_to business_room_path id: room.id
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:report_destroy) do
        FactoryBot.create :report, user_id: employee.id,
          room_id: room.id, comment: "ysk"
      end
      before {delete :destroy, params: {room_id: room.id, id: report.id, locale: :vi}}
      context "when destroy report success" do
        it "redirect to business_home_path" do
          expect{
            delete :destroy, params: {room_id: room.id, id: report_destroy.id}
          }.to change(Report, :count).by(-1)
        end

        it "should found" do
          expect(response).to have_http_status Settings.rspec.redirect_status
        end
      end
    end
  end
end
