require 'test_helper'

class SentMailTest < ActiveSupport::TestCase
  def setup
  	@user = users(:exuser)
  	@user2 = users(:exuser2)

  	@sent_mail = SentMail.new(	sender_address: "user@example.com",
  								recipient_address: "user2@example.com",
  								subject: "Hello",
  								message: "Hello, world!")
  end

  test "should be valid" do
  	assert @sent_mail.valid?
  end

  test "sender_address should be present" do
  	@sent_mail.sender_address = "     "
  	assert_not @sent_mail.valid?
  end

  test "recipient_address should be present" do
  	@sent_mail.recipient_address = "     "
  	assert_not @sent_mail.valid?
  end

  test "sender_address should not be too long" do
  	@sent_mail.sender_address = "a" * 244 + "@example.com"
  	assert_not @sent_mail.valid?
  end

  test "recipient_address should not be too long" do
  	@sent_mail.recipient_address = "a" * 244 + "@example.com"
  	assert_not @sent_mail.valid?
  end

  test "subject should not be too long" do
  	@sent_mail.subject = "a" * 256
  	assert_not @sent_mail.valid?
  end

  test "sender_address should have email format" do
  	valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_emails.each do |v|
  		@user.update_attribute(:email, v)
  		@sent_mail.sender_address = v
  		assert @sent_mail.valid?, "#{v.inspect} should be valid"
  	end
  end

  test "sender_address should not have not email format" do
  	invalid_emails = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
  	invalid_emails.each do |i|
  		@user.update_attribute(:email, i)
  		@sent_mail.sender_address = i
  		assert_not @sent_mail.valid?, "#{i.inspect} should be invalid"
  	end
  end

  test "recipient_address should have email format" do
  	valid_emails = %w[USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  	valid_emails.each do |v|
  		@user2.update_attribute(:email, v)
  		@sent_mail.recipient_address = v
  		assert @sent_mail.valid?, "#{v.inspect} should be valid"
  	end
  end

  test "recipient_address should not have not email format" do
  	invalid_emails = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
  	invalid_emails.each do |i|
  		@user2.update_attribute(:email, i)
  		@sent_mail.recipient_address = i
  		assert_not @sent_mail.valid?, "#{i.inspect} should be invalid"
  	end
  end

  test "sender_address should not be not a user's email" do
  	@sent_mail.sender_address = @user.email + "a"
  	@sent_mail.recipient_address = @user.email
  	assert_not @sent_mail.valid?
  end

  test "recipient_address should not be not a user's email" do
  	@sent_mail.sender_address = @user.email
  	@sent_mail.recipient_address = @user.email + "a"
  	assert_not @sent_mail.valid?
  end
end
