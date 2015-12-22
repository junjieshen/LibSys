class Notify < ApplicationMailer
  default from: 'no-reply@libsys.tk'
  def welcome_email(user)
    @user = user
    @url = 'http://libsys.tk/login_member'
    mail(to: @user.email, subject: "Welcome To LibSys")
  end
  def notify_availability(user,book)
    @user = user
    @book = book
    @url = "http://libsys.tk/books/#{book.id}"
    @subject = "Book #{book.title} Available!"
    mail(to: @user.email, subject: @subject)
  end
  def notify_subscription(user,book)
    @user = user
    @book = book
    @url = "http://libsys.tk/books/#{book.id}"
    @subject = "Subscription to Book #{book.title}"
    mail(to: @user.email, subject: @subject)
  end
  def notify_unsubscription(user,book)
        @user = user
            @book = book
                @url = "http://libsys.tk/books/#{book.id}"
                    @subject = "Unsubscription from Book #{book.title}"
                        mail(to: @user.email, subject: @subject)
                          end
end
