class User < ActiveRecord::Base
  has_secure_password

  before_save {|user| user.email = user.email.downcase}
  validates :name,  presence: true, length:{maximum: 50}
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length:{minimum: 6}
  validates :password_confirmation, presence: true

end
