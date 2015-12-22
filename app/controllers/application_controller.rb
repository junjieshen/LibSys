class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  protected 
    def authenticate_admin
        username = session[:user_id]
        @admin_list = Admin.all
        temp = false
        @admin_list.each do |row|
         temp = temp || (username == row.email)
        end
        if temp
          return
        else
          flash[:notice] = "No Monkey Business!"
          redirect_to root_url
        end
    end
    def authenticate_member
      username = session[:user_id]
      current_login = Member.where(email: username).first
      if current_login || session[:is_admin?]
        @member = current_login
       #if current_login.id.to_s == params[:id]
          return
        else
            flash[:notice] = "No Monkey Business!"
            redirect_to root_url        
        #end
      end
    end
end
