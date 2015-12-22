class Suggestion < ActiveRecord::Base
  validates :member_email, presence: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates_numericality_of :ISBN, presence: true, uniqueness: { case_sensitive: false }, :in => 1..9223372036854775807
  validates :title, presence: true
  validates :description, presence: true
  validates :authors, presence: true
end
