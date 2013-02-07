class User < Ohm::Model
  include Shield::Model

  def self.fetch email
    with(:email, email)
  end

  attribute :email
  attribute :crypted_password
  unique :email
end

class CreateUser < Scrivener
  attr_accessor :email, :password

  def validate
    if assert_present :email and assert_email :email
      assert !User.fetch(email), [:email, :not_unique]
    end

    assert_present :password
  end

  def create
    User.create attributes
  end
end
