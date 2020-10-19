require "rails_helper"
RSpec.describe Room, type: :model do
  let(:room) {FactoryBot.create :room}
  let!(:room_fail) do
    FactoryBot.build :room,
                     name: nil,
                     user_id: nil,
                     location_id: nil,
                     address: Faker::String.random(length: 101)
  end

  describe "Enums" do
    it "active room" do
      is_expected.to define_enum_for(:active).with_values({locked: false, opened: true})
                                             .backed_by_column_of_type(:boolean)
    end
  end

  describe "Associations" do
    it "has many events" do
      is_expected.to have_many(:events).dependent(:destroy)
    end

    it "has many reports" do
      is_expected.to have_many(:reports).dependent(:destroy)
    end

    it "has many images" do
      is_expected.to have_many(:images).dependent(:destroy)
    end

    it "belongs to user" do
      is_expected.to belong_to(:user)
    end

    it "belongs to location" do
      is_expected.to belong_to(:location)
    end
  end

  describe "Nested attributes" do
    it "accept nested attribute for images" do
      is_expected.to accept_nested_attributes_for(:images).allow_destroy(true)
    end
  end

  describe "Delegates" do
    it "delegate name to location" do
      is_expected.to delegate_method(:name).to(:location).with_prefix(true).allow_nil
    end
  end

  describe "Validations" do
    it "required all field" do
      expect(room.valid?).to eq true
    end

    it "required missing field" do
      expect(room_fail.valid?).to eq false
    end
  end

  describe "Callbacks" do
    let!(:event) do
      FactoryBot.create :event,
                       room_id: room.id,
                       status: :activate
    end

    context "when updated" do
      it "after_update" do
        obj = double
        allow(obj).to receive(:send_email).and_return "pass"
        room.update active: :locked
        expect(room.events.first.status).to eq "inactivate"
      end
    end

  end

  describe "Scopes" do
    include_examples "create example rooms"

    describe ".join_location_country" do
      context "includes three tables" do
        it "return record of three tables" do
          expect(Room.join_location_country.size).to eq(Room.count)
        end
      end
    end

    describe ".sort_by_created_at" do
      context "when param is asc" do
        it "return rooms sort by asc" do
          expect(Room.sort_by_created_at(:asc)).to eq([moscow, room2, room3])
        end
      end

      context "when param is desc" do
        it "return rooms sort by desc" do
          expect(Room.sort_by_created_at(:desc)).to eq([room3, room2, moscow])
        end
      end
    end
  end

  describe "Class method" do
    it ".ransackable_attributes" do
      expect(Room.ransackable_attributes).to eq(["name", "address", "location_id", "title", "active", "created_at", "updated_at"])
    end
  end
end
