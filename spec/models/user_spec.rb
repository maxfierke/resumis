require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory'
  it 'is invalid without a first_name'
  it 'is invalid without a last_name'
  it 'is invalid without a subdomain in multi-tenancy mode'
  it 'needs a unique subdomain in multi-tenancy mode'
  it 'can not use a reserved subdomain as its subdomain'
  it 'returns a full_name as a concat. of first_name and last_name'
  it 'returns a gravatar url from its email'

  describe '#copyright_range' do
    it 'returns only the current year if only one year has spanned'
    it 'returns the full span of years if more than a year old'
  end
end
