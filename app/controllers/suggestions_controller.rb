class SuggestionsController < ApplicationController
  before_filter :authenticate_admin, only: [:index, :approve, :update, :destroy]
  before_filter :authenticate_member, only: [:create]
  def index
    @suggestions = Suggestion.where(active: true)
  end
  def show
    @suggestion = Suggestion.where(active: true, id: params[:id]).first
    if @suggestion
      render 'show'
    else
      flash[:notice] = "Page not Found!"
      redirect_to '/books'
    end
  end
  def new
    @suggestion = Suggestion.new
    @suggestion.member_email = session[:user_id]
  end
  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.member_email = session[:user_id]
    if @suggestion.save
      redirect_to @suggestion
    else
      render 'new'
    end
  end
  def approve
    @page = "approve"
    @suggestion = Suggestion.find(params[:id])
  end
  def update
    @suggestion = Suggestion.find(params[:id])
    if @suggestion.update(suggestion_params)
      @suggestion.update_attribute(:active,false)
      @book = Book.new
      @book.ISBN = @suggestion.ISBN
      @book.title = @suggestion.title
      @book.description = @suggestion.description
      @book.authors = @suggestion.authors
      if @book.save
        flash[:notice] = "Suggestion for #{@suggestion.title} has been approved"
        redirect_to '/suggestions'
      end
    else
      flash[:notice] = "Error in Approving Suggestion for #{@suggestion.title}"
      render 'approve'
    end
  end
  def destroy
    @suggestion = Suggestion.find(params[:id])
 #   @suggestion.update_attribute(:active,false)
    @suggestion.active = false
    if @suggestion.save
      redirect_to suggestions_url
    else
      render 'index'
    end
  end

  private
  def suggestion_params
    params.require(:suggestion).permit(:member_email,:ISBN,:title,:authors,:description)
  end
end
