class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to books_url
    end
  end
end
