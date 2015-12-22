class Subscription < ActiveRecord::Base
  validates :member_email, presence: true
  validates :book_id, presence: true
end
