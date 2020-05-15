require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should validate presence of name" do
    a = User.new()
    assert_not a.valid?
    assert a.errors.full_messages.include? "Name can't be blank"
    assert a.errors.full_messages_for(:name).size  == 1
  end
end
