class History < ActiveRecord::Base
  validates :book_id, presence: true
  validates :member_email, presence: true
  validates :status, presence: true, inclusion: { in: %w(Checkedout Returned)}
end
