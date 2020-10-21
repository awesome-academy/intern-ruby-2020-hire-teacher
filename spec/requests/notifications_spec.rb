require 'rails_helper'

RSpec.describe Business::NotificationsController, type: :controller do
  describe "GET index" do
    it "with all notification" do
      expect(response).to have_http_status Settings.rspec.success_status
    end
  end
end
