module BooksHelper
  def subscribed?(book_id)
    subscription = Subscription.where(active: true, member_email: session[:user_id], book_id: book_id).first
    if !subscription.nil?
      true
    else
      false
    end
  end
end
