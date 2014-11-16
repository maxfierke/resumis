require 'test_helper'

class ProjectStatusesControllerTest < ActionController::TestCase
  setup do
    @project_status = project_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_status" do
    assert_difference('ProjectStatus.count') do
      post :create, project_status: { name: @project_status.name, slug: @project_status.slug }
    end

    assert_redirected_to project_status_path(assigns(:project_status))
  end

  test "should show project_status" do
    get :show, id: @project_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_status
    assert_response :success
  end

  test "should update project_status" do
    patch :update, id: @project_status, project_status: { name: @project_status.name, slug: @project_status.slug }
    assert_redirected_to project_status_path(assigns(:project_status))
  end

  test "should destroy project_status" do
    assert_difference('ProjectStatus.count', -1) do
      delete :destroy, id: @project_status
    end

    assert_redirected_to project_statuses_path
  end
end
