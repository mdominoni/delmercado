require_relative '../test_helper'

class UserTest < Test::Unit::TestCase
  test "email uniqueness on new" do
    user1 = User.create(email: 'foo@bar.com', password: 'foo')
    user2 = CreateUser.new(email: user1.email, password: 'bar')

    assert !user2.valid?
    assert user2.errors[:email].include? :not_unique

    user2.email = 'bar@foo.com'

    assert user2.valid?
  end
end
