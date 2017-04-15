require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(email: "user@example.com", name: "Example User")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "     "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "     "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email should have email format" do
  	valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_emails.each do |v|
  		@user.email = v
  		assert @user.valid?, "#{v.inspect} should be valid"
  	end
  end

  test "email should not have not email format" do
  	invalid_emails = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
  	invalid_emails.each do |i|
  		@user.email = i
  		assert_not @user.valid?, "#{i.inspect} should be invalid"
  	end
  end

  test "emails should be unique" do
  	dup = @user.dup
  	dup.email = @user.email.upcase
  	@user.save
  	assert_not dup.valid?
  end
end
