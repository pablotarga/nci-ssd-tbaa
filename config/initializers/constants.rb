# source: https://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates
EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

APP_DOMAIN = ENV.fetch('APP_DOMAIN'){ 'localhost' }
