class SessionsController < ApplicationController
  def new_member
  end

  def new_admin
  end

  def create_member
    member = Member.find_by(email: params[:session][:email].downcase)
    if member && member.authenticate(params[:session][:password]) && member.active
      log_in member
      is_admin?
      redirect_to books_url
    else
        flash[:notice] = 'Invalid email/password combination'
      render 'new_member'
    end
  end

  def create_admin
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password]) && admin.active
      log_in admin
      is_admin?
      redirect_to admin
    else
        flash[:notice] = 'Invalid email/password combination'
      render 'new_admin'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
