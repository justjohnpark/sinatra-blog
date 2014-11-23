class User < ActiveRecord::Base
  validates :first_name, :email, :password_hash, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  has_many :entries

  def password
    self.password_hash
  end

  def password=(new_password)
    if new_password.length > 0
      self.password_hash = BCrypt::Password.create(new_password)
    end
  end

  def authenticate(input_password)
    BCrypt::Password.new(self.password) == input_password
  end

  def first_error
    message = self.errors.messages.first[1][0]
    location = self.errors.messages.first[0]
    "#{location.capitalize} #{message}"
  end    
end
