module SessionsHelper
  def log_in(user)
    session[:user_id] = user.email
  end
  def current_user
    @current_user = @current_user || Member.find_by(email: session[:user_id]) || Admin.find_by(email: session[:user_id])
  end
  def is_admin?
    session[:is_admin?] = Admin.find_by(email: session[:user_id])
  end
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
