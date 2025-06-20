require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    User.delete_all  # Xóa toàn bộ record tránh bị lỗi email trùng
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages.to_s
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
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

  test "email validation should accept valid addresses" do
    valid_addresses = %w[
      user@example.com
      USER@foo.COM
      A_US-ER@foo.bar.org
      first.last@foo.jp
      alice+bob@baz.cn
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid. Errors: #{@user.errors.full_messages}"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[
      user@example,com
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com
      foo@bar+baz.com
      foo@bar..com
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
  @user.save!
  duplicate_user = @user.dup
  duplicate_user.email = @user.email.upcase
  assert_not duplicate_user.valid?, "Duplicate email should be invalid"
end


  test "email should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "password should not be too long" do
    @user.password = @user.password_confirmation = "a" * 73  # vượt quá 72
    assert_not @user.valid?, "Password length: #{@user.password.length} should be invalid"
  end

  test "name should not contain special characters" do
    @user.name = "John@Doe!"
    assert_not @user.valid?
  end

  test "should allow valid names" do
    valid_names = [ "John Doe", "Alice Smith", "Bob Johnson" ]
    valid_names.each do |valid_name|
      @user.name = valid_name
      assert @user.valid?, "#{valid_name.inspect} should be valid. Errors: #{@user.errors.full_messages}"
    end
  end

  test "email validation should reject addresses with multiple dots" do
    invalid_addresses = [ "user@foo..com", "foo@bar..baz.com" ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
