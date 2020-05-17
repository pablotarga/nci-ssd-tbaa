class RestrictedAccessController < ApplicationController
  before_action :authenticate_user!

end
