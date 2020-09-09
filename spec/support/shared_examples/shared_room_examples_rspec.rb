RSpec.shared_examples "create example rooms" do
  include_examples "create example users"

  let!(:vietnam){
    FactoryBot.create(
      :country,
      name: "Vietnam"
    )
  }
  let!(:japan){
    FactoryBot.create(
      :country,
      name: "Japan"
    )
  }
  let!(:hanoi){
    FactoryBot.create(
      :location,
      name: "Hanoi",
      country_id: vietnam.id
    )
  }
  let!(:danang){
    FactoryBot.create(
      :location,
      name: "Danang",
      country_id: vietnam.id
    )
  }
  let!(:tokyo){
    FactoryBot.create(
      :location,
      name: "Tokyo",
      country_id: japan.id
    )
  }
  let!(:moscow){
    FactoryBot.create(
      :room,
      name: "Moscow",
      address: "Handico",
      active: :opened,
      location_id: hanoi.id
    )
  }
  let!(:room2){
    FactoryBot.create(
      :room,
      name: "Room2",
      address: "Danang2",
      active: :locked,
      location_id: danang.id
    )
  }
  let!(:room3){
    FactoryBot.create(
      :room,
      name: "Room3",
      address: "Tokyo address",
      active: :opened,
      location_id: tokyo.id
    )
  }
end
