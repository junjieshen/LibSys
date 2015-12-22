require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  setup do
    @super_admin = admins(:one)
    @admin = admins(:two)
    log_in_admin(@admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin" do
    assert_difference('Admin.count') do
      post :create, admin: { email: "abc@abc.com", name: "abc", password: "abc", password_confirmation: "abc" }
    end
    assert_redirected_to admin_path(assigns(:admin))
  end

  test "should show admin" do
    get :show, id: @admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin
    assert_response :success
  end

  test "should update admin" do
    patch :update, id: @admin, admin: { email: @admin.email, name: @admin.name, password_digest: @admin.password_digest }
    assert_redirected_to admin_path(assigns(:admin))
  end

  test "should not destroy self" do
    assert_difference('Admin.count', 0) do
      delete :destroy, id: @admin
    end
    assert_redirected_to admins_path
  end
end
