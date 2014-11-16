require 'test_helper'

class WorkExperiencesControllerTest < ActionController::TestCase
  setup do
    @work_experience = work_experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_experience" do
    assert_difference('WorkExperience.count') do
      post :create, work_experience: { description: @work_experience.description, end_date: @work_experience.end_date, organization: @work_experience.organization, start_date: @work_experience.start_date }
    end

    assert_redirected_to work_experience_path(assigns(:work_experience))
  end

  test "should show work_experience" do
    get :show, id: @work_experience
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_experience
    assert_response :success
  end

  test "should update work_experience" do
    patch :update, id: @work_experience, work_experience: { description: @work_experience.description, end_date: @work_experience.end_date, organization: @work_experience.organization, start_date: @work_experience.start_date }
    assert_redirected_to work_experience_path(assigns(:work_experience))
  end

  test "should destroy work_experience" do
    assert_difference('WorkExperience.count', -1) do
      delete :destroy, id: @work_experience
    end

    assert_redirected_to work_experiences_path
  end
end
