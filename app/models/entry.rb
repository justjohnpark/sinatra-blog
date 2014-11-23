class Entry < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true

  def first_error
    message = self.errors.messages.first[1][0]
    location = self.errors.messages.first[0]
    "#{location.capitalize} #{message}"
  end
end
