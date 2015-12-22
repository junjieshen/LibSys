require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  def setup
    @admin = Admin.new(name: "Test User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "admin should be valid" do 
    assert @admin.valid?
  end
  
  test "name should be present" do 
    @admin.name = "  " 
    assert_not @admin.valid?
  end

  test "email should be present" do 
    @admin.email = "  " 
    assert_not @admin.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[member@example.com MEMBER@foo.COM A_US-CN@foo.bar.org
                        first.last@foo.jp wiki_jack@baidu.cn]
    valid_addresses.each do |valid_address|
      @admin.email = valid_address
      assert @admin.valid?, "#{valid_address.inspect} should be valid"
    end 
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[member@example,com user_at_foo.org user.name@example.]
    invalid_addresses.each do |invalid_address|
      @admin.email = invalid_address
      assert_not @admin.valid?, "#{invalid_address.inspect} should be invalid"
    end 
  end
  
  test "email addresses should be unique" do
    dup_admin = @admin.dup
    dup_admin.email = @admin.email.upcase
    @admin.save
    assert_not dup_admin.valid?
  end
  
  test "email addresses should be saved as lower-case" do 
    mixed_case_email = "Foo@ExAMPle.CoM"
    @admin.email = mixed_case_email
    @admin.save
    assert_equal mixed_case_email.downcase, @admin.reload.email 
  end
end
