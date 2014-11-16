require 'test_helper'

class SkillCategoriesControllerTest < ActionController::TestCase
  setup do
    @skill_category = skill_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:skill_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skill_category" do
    assert_difference('SkillCategory.count') do
      post :create, skill_category: { name: @skill_category.name }
    end

    assert_redirected_to skill_category_path(assigns(:skill_category))
  end

  test "should show skill_category" do
    get :show, id: @skill_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @skill_category
    assert_response :success
  end

  test "should update skill_category" do
    patch :update, id: @skill_category, skill_category: { name: @skill_category.name }
    assert_redirected_to skill_category_path(assigns(:skill_category))
  end

  test "should destroy skill_category" do
    assert_difference('SkillCategory.count', -1) do
      delete :destroy, id: @skill_category
    end

    assert_redirected_to skill_categories_path
  end
end
