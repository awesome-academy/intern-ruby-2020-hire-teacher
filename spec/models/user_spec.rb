require "rails_helper"
RSpec.describe User, type: :model do
  let!(:user) {FactoryBot.build :user}
  let!(:user_fail) {FactoryBot.build :user, email: nil}

  describe "Validations" do
    it "required all field" do
      expect(user.valid?).to eq true
    end

    it "required missing field" do
      expect(user_fail.valid?).to eq false
    end
  end

  describe "Associations" do
    it "has many events" do
      is_expected.to have_many(:events).dependent(:destroy)
    end

    it "has many guests" do
      is_expected.to have_many(:guests).dependent(:destroy)
    end

    it "has many reports" do
      is_expected.to have_many(:reports).dependent(:destroy)
    end

    it "has many rooms" do
      is_expected.to have_many(:rooms).dependent(:destroy)
    end

    it "belongs to group" do
      is_expected.to belong_to(:group)
    end
  end

  describe "Delegates" do
    it "delegate name for group" do
      is_expected.to delegate_method(:name).to(:group).with_prefix(true)
    end
  end

  describe "Enums" do
    it "role user" do
      is_expected.to define_enum_for(:role).with_values({manager: 1, employee: 2, trainer: 3, trainee: 4})
    end
  end

  describe "Scopes" do
    include_examples "create example users"

    describe ".by_name" do
      context "when nil params" do
        it "return all user" do
          expect(User.by_name(nil).size).to eq(4)
        end
      end

      context "when valid params" do
        it "return user" do
          expect(User.by_name("tra")).to eq([account_trainer, account_trainee])
        end
      end
    end

    describe ".by_email" do
      context "when nil params" do
        it "return all user" do
          expect(User.by_email(nil).size).to eq(4)
        end
      end

      context "when valid params" do
        it "return user" do
          expect(User.by_email("user").size).to eq(4)
        end
      end
    end

    describe ".by_group" do
      context "when nil params" do
        it "return all user" do
          expect(User.by_group(nil).size).to eq(4)
        end
      end

      context "when valid params" do
        it "return group manager" do
          expect(User.by_group(group_manager.id)).to eq([account_manager])
        end

        it "return group RUBY" do
          expect(User.by_group(group_ruby.id)).to eq([account_trainer, account_trainee])
        end
      end
    end

    describe ".by_role" do
      context "when nil params" do
        it "return all user" do
          expect(User.by_role(nil).size).to eq(4)
        end
      end

      context "when valid params" do
        it "return role manager" do
          expect(User.by_role(1)).to eq([account_manager])
        end

        it "return role employee" do
          expect(User.by_role(2)).to eq([account_employee])
        end
      end
    end

    describe ".by_status" do
      context "when nil params" do
        it "return all user" do
          expect(User.by_status(nil).size).to eq(4)
        end
      end

      context "when valid params" do
        it "return account activated" do
          expect(User.by_status(true)).to eq([account_manager, account_employee, account_trainer])
        end
      end
    end
  end
end
