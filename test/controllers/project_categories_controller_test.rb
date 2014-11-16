require 'test_helper'

class ProjectCategoriesControllerTest < ActionController::TestCase
  setup do
    @project_category = project_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_category" do
    assert_difference('ProjectCategory.count') do
      post :create, project_category: { name: @project_category.name, slug: @project_category.slug }
    end

    assert_redirected_to project_category_path(assigns(:project_category))
  end

  test "should show project_category" do
    get :show, id: @project_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project_category
    assert_response :success
  end

  test "should update project_category" do
    patch :update, id: @project_category, project_category: { name: @project_category.name, slug: @project_category.slug }
    assert_redirected_to project_category_path(assigns(:project_category))
  end

  test "should destroy project_category" do
    assert_difference('ProjectCategory.count', -1) do
      delete :destroy, id: @project_category
    end

    assert_redirected_to project_categories_path
  end
end
