class BooksController < ApplicationController
    before_filter :authenticate_admin, only: [:create, :edit, :update, :destroy], except: [:subscribe, :unsubscribe]
    before_filter :authenticate_member, only: [:subscribe, :unsubscribe]
  def index
    @books = Book.where(active: true)
  end
  def show
    @book = Book.find(params[:id])
    if @book.status != "Available"
      @history = History.where(book_id: @book.id, status: "Checkedout").first
      holder_email = @history.member_email
      @holder = Member.find_by(:email => holder_email)
    end
  end
  def new
    @book = Book.new
  end
  def edit
    @page = "edit"
    @book = Book.find(params[:id])
  end
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end
  def destroy
    @book = Book.find(params[:id])
    if !History.where(book_id: @book.id, status: "Checkedout").first
      @book.active = false
      if @book.save
        redirect_to books_url
      else
        render 'index'
      end
    else
      flash[:notice] = "Unable to Delete Book. Its been Borrowed. Please Return book before deleting it!"
      redirect_to '/books'
    end
  end
  def search
    logger.info "Here lies #{params[:item]}"
    @entry = Book.where(ISBN: params[:item], active: true) + Book.where(title: params[:item], active: true) + Book.where(authors: params[:item], active: true) + Book.where(status: params[:item], active: true)
    @entry = @entry.uniq
  end
  def checkout
    if session[:is_admin?]
      @is_admin = true
    else
      @is_admin = false
    end
    
    @history = History.new
    if @is_admin
      if Member.where(email: params[:item], active: true).first
      @history.member_email = params[:item]
    end
    else
      @history.member_email = session[:user_id]
    end
    @book = Book.find(params[:book_id])
    
    if @history.member_email != nil
      @history.book_id = params[:book_id]
      @history.checkout_at = Time.now.to_datetime
      @history.status = "Checkedout"
      logger.info "history: #{@history}"
      if @history.save
        @book.update_attribute(:status, "Checked Out")
        redirect_to @book
      
      end
    else
      flash[:error] = "Member doesn't exist. Please enter a valid email ID!"
      render 'checkout'
    end
  end
  
  def borrow
    #flash[:success] = "You have successfully checked out the book!"
    # @history = History.create(book_id:params[:book_id], member_email:params[:member_email], status:"Checkedout")
    if session[:is_admin?]
      @is_admin = true
    else
      @is_admin = false
    end
    @book = Book.find(params[:book_id])
    
  end
  def list_history
    @book = Book.find(params[:book_id])
    @history_list = History.where(book_id: @book.id)
    render 'list_history'
  end
  def subscribe
    @book = Book.find(params[:id])
    @user = Member.find_by(email: session[:user_id])
    @subscription = Subscription.where(member_email: @user.email, book_id: @book.id).first
    if !@subscription.nil?
      if @subscription.active == false
        @subscription.update_attribute(:active,true)
        flash[:notice] = "Subscribed to Book #{@book.title}!"
        Notify.notify_subscription(@user,@book).deliver_now
        render 'show'
      else
        flash[:notice] = "Already Subscribed!"
        render 'show'
      end
    else
      @subscription = Subscription.new(:member_email => session[:user_id],:book_id => @book.id)
      if @subscription.save
        flash[:notice] = "Subscribed to Book #{@book.title}!"
        Notify.notify_subscription(@user,@book).deliver_now
        render 'show'
      else
        flash[:notice] = "Error Subscribing to Book #{@book.title}"
        render 'show'
      end
    end
  end
  def unsubscribe
    @book = Book.find(params[:id])
    @user = Member.find_by(email: session[:user_id])
    @subscription = Subscription.where(active: true, member_email: @user.email, book_id: @book.id).first
    logger.info "logg #{@subscription}"
    if @subscription.update_attribute(:active,false)
      flash[:notice] = "Unsubscribed from Book #{@book.title}!"
      Notify.notify_unsubscription(@user,@book).deliver_now
      render 'show'
    else
      flash[:notice] = "Error Unsubscribing from Book #{@book.title}"
      render 'show'
    end
  end
  private
    def book_params
      params.require(:book).permit(:ISBN,:title,:authors,:description,:status)
    end
end
