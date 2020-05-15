class User < ApplicationRecord
  # password hashing and salting using bcrypt gem
  # will inject a set of different methods to handle, modify and check the password in a safe way
  # provide a :password= method that accepts a plain password and it will hash and salt it and store into password_digest field
  # provide authenticate method that accepts a plain password and it will check if informed password matches the encrypted password stored in the db
  has_secure_password

  # name and email must be informed, duh!
  # rails accepts multiple fields to be validated by the same set of configurations
  validates :name, :email, presence: true

  # name must contain from 2 to 30 characters, allow_blank option will avoid doubling up errors with presence and too short, once "".size == 0
  validates :name, length: {minimum:2, maximum:30}, allow_blank: true

  # email must unique and match informed EMAIL_REGEX (this is defined in config/initializers/constants.rb)
  # allow blank is to skip this validation if email is blank, which will be taken care on the presence validation
  # raill accepts multiple set of validations (like on this example I'm using uniqueness and format)
  validates :email, uniqueness: true, format: {with: EMAIL_REGEX}, allow_blank: true
end
