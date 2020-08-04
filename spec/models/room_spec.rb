require "rails_helper"
RSpec.describe Room, type: :model do
  let!(:room) {FactoryBot.build :room}
  let!(:room_fail) {FactoryBot.build :room, name: nil}

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
      is_expected.to delegate_method(:name).to(:location).with_prefix(true)
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

  describe "Scopes" do
    include_examples "create example rooms"

    describe ".join_location_country" do
      context "includes three tables" do
        it "return record of three tables" do
          expect(Room.join_location_country.size).to eq(Room.count)
        end
      end
    end

    describe ".by_name" do
      context "when nil params" do
        it "return all room" do
          expect(Room.by_name(nil).size).to eq(Room.count)
        end
      end

      context "when valid params" do
        it "return room" do
          expect(Room.by_name("mos")).to eq([moscow])
        end
      end
    end

    describe ".by_location" do
      context "when nil params" do
        it "return all room" do
          expect(Room.by_location(nil).size).to eq(Room.count)
        end
      end

      context "when valid params" do
        it "return room" do
          expect(Room.by_location(tokyo.id)).to eq([room3])
        end
      end
    end

    describe ".by_country" do
      context "when nil params" do
        it "return all room" do
          expect(Room.by_country(nil).size).to eq(Room.count)
        end
      end

      context "when valid params" do
        it "return room" do
          expect(Room.by_country(vietnam.id)).to eq([moscow, room2])
        end
      end
    end

    describe ".by_created_at" do
      context "when nil params" do
        it "return all room" do
          expect(Room.by_created_at(nil).size).to eq(Room.count)
        end
      end

      context "when valid params" do
        it "return room" do
          expect(Room.by_created_at room2.created_at.to_date).to eq([moscow, room2, room3])
        end
      end
    end

    describe ".by_active" do
      context "when nil params" do
        it "return all room" do
          expect(Room.by_active(nil).size).to eq(Room.count)
        end
      end

      context "when valid params" do
        it "return room" do
          expect(Room.by_active(:opened)).to eq([moscow, room3])
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
end
