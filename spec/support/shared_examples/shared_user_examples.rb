RSpec.shared_examples "create example users" do
    let!(:group_manager){
      FactoryBot.create(
        :group,
        name: "Manager"
      )
    }
    let!(:group_php){
      FactoryBot.create(
        :group,
        name: "PHP"
      )
    }
    let!(:group_ruby){
      FactoryBot.create(
        :group,
        name: "Ruby"
      )
    }
    let!(:account_manager) {FactoryBot.create(
      :user,
      name: "Manager",
      email: "user1@test.com",
      role: 1,
      group_id: group_manager.id,
      activated: true
    )}
    let!(:account_employee) {FactoryBot.create(
      :user,
      name: "Employee",
      email: "user2@test.com",
      role: 2,
      group_id: group_php.id,
      activated: true
    )}
    let!(:account_trainer) {FactoryBot.create(
      :user,
      name: "Trainer",
      email: "user3@test.com",
      role: 3,
      group_id: group_ruby.id,
      activated: true
    )}
    let!(:account_trainee) {FactoryBot.create(
      :user,
      name: "Trainee",
      email: "user4@test.com",
      role: 4,
      group_id: group_ruby.id,
      activated: false
    )}
end
