ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "bcrypt"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end
  
  def log_in_admin(user, options = {})
    session[:user_id] = user.email
    @current_user = user
  end

  def is_admin?
    session[:is_admin?] = Admin.find_by(email: session[:user_id])
  end

end
