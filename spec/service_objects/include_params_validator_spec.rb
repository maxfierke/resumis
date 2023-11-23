require 'rails_helper'

RSpec.describe IncludeParamsValidator do
  let(:allowed) do
    %w(foo foo.* blim blim.blam flim flim.flam.**)
  end

  describe '#valid?' do
    let(:validator) do
      IncludeParamsValidator.new(
        include_params: include_params,
        allowed: allowed
      )
    end

    context 'all include params are all in allowed list' do
      let(:include_params) do
        %w(foo foo.* blim)
      end

      it 'returns true' do
        expect(validator.valid?).to be(true)
      end
    end

    context 'some include params are not in the allowed list' do
      let(:include_params) do
        %w(foo bar baz)
      end

      it 'returns false' do
        expect(validator.valid?).to be(false)
      end
    end
  end

  describe '#include_params!' do
    let(:validator) do
      IncludeParamsValidator.new(
        include_params: include_params,
        allowed: allowed
      )
    end

    context 'all include params are all in allowed list' do
      let(:include_params) do
        %w(foo.* blim)
      end

      it 'returns true' do
        expect(validator.include_params!).to match_array(include_params)
      end
    end

    context 'some include params are not in the allowed list' do
      let(:include_params) do
        %w(foo bar baz)
      end

      it 'raises an InvalidIncludesError' do
        expect { validator.include_params! }.to raise_error(InvalidIncludesError)
      end
    end
  end
end
