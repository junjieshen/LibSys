class MembersController < ApplicationController
  #before_action :set_member, only: [:show, :edit, :update]
  before_filter :authenticate_member, except: [:index, :destroy]
  #before_filter :authenticate_admin, only: [:index, :show, :create, :edit, :destroy]
  # GET /members
  # GET /members.json
  def index
    @members = Member.where(active: true)
  end

  # GET /members/1
  # GET /members/1.json
  def show
    curr_user = Member.find_by(email: session[:user_id])
    if (curr_user && curr_user.id.to_s == params[:id]) || session[:is_admin?]
      @member = Member.find(params[:id])
      checkout_list = History.where(member_email: @member.email, status: "Checkedout")
      @book_list = []
      book_id_list = checkout_list.map { |x| x[:book_id] }
      book_id_list.each do |id|
        @book_list << id
      end
   else
     flash[:notice] = "No Monkey Business!"
     redirect_to '/books'                                                     
   end
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    curr_user = Member.find_by(email: session[:user_id])
    if (curr_user && curr_user.id.to_s == params[:id]) || session[:is_admin?]
      @member = Member.find(params[:id])
      render 'edit'
    else
      flash[:notice] = "No Monkey Business!"
      redirect_to '/books'
    end
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.where(email: params[:member][:email]).first
    if @member
    @member.active = true
    @member.update(member_params)
    else
    @member = Member.new(member_params)
    end
    respond_to do |format|
      if @member.save
        Notify.welcome_email(@member).deliver_now
        if current_user.nil?
          log_in @member
          is_admin?
          format.html { redirect_to @member, notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { redirect_to @member, notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        end
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
        if @member.update(member_params)
          format.html { redirect_to @member, notice: 'Member was successfully updated.' }
          format.json { render :show, status: :ok, location: @member }
        else
          format.html { render :edit }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
    end
  end
  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    if !History.where(member_email: @member.email, status: "Checkedout").first
      @member.active = false

      if @member.save
        redirect_to members_url
      else
        render 'index'
      end
    else
      flash[:notice] = "Unable to Delete Member.Please Return his/her borrowed book(s) before deleting Member!"
      redirect_to "/members/#{params[:id]}"
    end
  end

  def list_history
    @member = Member.find_by(:email => params[:member_email])
    @history_list = History.where(member_email: params[:member_email])
    render 'list_history'
  end
  
  def return_book
    @member = Member.find(params[:member_id])
    # Modify book holder, status
    book = Book.find(params[:book_id])
    book.update_attribute(:status, "Available")
    @subscriptions = Subscription.where(active: true, book_id: book.id)
    @subscriptions.each do |subscription|
      member = Member.find_by(email: subscription.member_email)
      Notify.notify_availability(member,book).deliver_now
    end
    # add history
    @history = History.where(book_id: book.id,member_email: @member.email,status:'Checkedout').first
    @history.return_at = Time.now.to_datetime
    @history.update_attribute(:return_at,@history.return_at)
    @history.update_attribute(:status, "Returned")
    redirect_to @member
  end
  def suggest
    @suggest_book = Suggestion.new
    render 'suggest'
  end
  def suggest_update
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :email, :password, :password_confirmation)
    end
end
