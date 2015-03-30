require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory'
  it 'is invalid without a title'
  it 'is invalid with a duplicate title (by user)'
  it 'is invalid with a title less than 3 characters'
  it 'is invalid with a title greater than 60 characters'
end
