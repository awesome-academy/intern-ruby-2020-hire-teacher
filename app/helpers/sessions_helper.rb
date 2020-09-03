module SessionsHelper
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def none_manager? user
    !user.manager?
  end
end
