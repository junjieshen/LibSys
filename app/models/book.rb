class Book < ActiveRecord::Base
  after_initialize :default_status
  validates :ISBN, presence: true, uniqueness: { case_sensitive: false }
  validates :title, presence: true
  validates :description, presence: true
  validates :authors, presence: true
  validates :status, presence: true, inclusion: { in: %w(Checked\ Out Available), message: "%{value} isn't a valid status for the book" }
  validates :holder, presence: true
  private
    def default_status
      self.status ||= "Available"
      self.holder ||= "Nobody"
    end
end
