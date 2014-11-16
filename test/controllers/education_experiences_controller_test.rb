require 'test_helper'

class EducationExperiencesControllerTest < ActionController::TestCase
  setup do
    @education_experience = education_experiences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:education_experiences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create education_experience" do
    assert_difference('EducationExperience.count') do
      post :create, education_experience: { description: @education_experience.description, end_date: @education_experience.end_date, school_name: @education_experience.school_name, start_date: @education_experience.start_date }
    end

    assert_redirected_to education_experience_path(assigns(:education_experience))
  end

  test "should show education_experience" do
    get :show, id: @education_experience
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @education_experience
    assert_response :success
  end

  test "should update education_experience" do
    patch :update, id: @education_experience, education_experience: { description: @education_experience.description, end_date: @education_experience.end_date, school_name: @education_experience.school_name, start_date: @education_experience.start_date }
    assert_redirected_to education_experience_path(assigns(:education_experience))
  end

  test "should destroy education_experience" do
    assert_difference('EducationExperience.count', -1) do
      delete :destroy, id: @education_experience
    end

    assert_redirected_to education_experiences_path
  end
end
