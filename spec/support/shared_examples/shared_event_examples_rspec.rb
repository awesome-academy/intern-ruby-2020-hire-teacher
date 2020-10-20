RSpec.shared_examples "create example events" do
  include_examples "create example users"
  include_examples "create example rooms"

  let!(:event1) {
    FactoryBot.create(
      :event,
      title: "Event1",
      room_id: moscow.id,
      user_id: account_employee.id
    )
  }

  let!(:event2) {
    FactoryBot.create(
      :event,
      title: "Event2",
      room_id: room2.id,
      user_id: account_trainer.id
    )
  }

  let!(:event3) {
    FactoryBot.create(
      :event,
      title: "Event3",
      room_id: room3.id,
      user_id: account_trainee.id
    )
  }
end
