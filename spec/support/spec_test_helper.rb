module SpecTestHelper
  def login user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user ||= FactoryBot.create(:user)
    sign_in user
  end

  def correct_manager
    return if current_user&.manager?

    flash[:warning] = t "managers.warning.not_correct"
    redirect_to business_home_path
  end

  def load_group
    @groups = {"#{t "option.all"}": ""}
    @groups.merge! Group.pluck(:name, :id).to_h
  end

  def load_role
    @roles = {"#{t "option.all"}": ""}
    @roles.merge! Settings.model.user.roles.to_h
  end

  def load_room
    @room = Room.find_by id: params[:id]
    @images = @room&.images
    return if @room.present?

    flash[:warning] = t "managers.warning.show_room", id: params[:id]
    redirect_to managers_rooms_path
  end
end
