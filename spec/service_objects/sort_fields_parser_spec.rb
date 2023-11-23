require 'rails_helper'

RSpec.describe SortFieldsParser do
  let(:allowed) do
    %w(foo blim flam)
  end

  describe '#valid?' do
    let(:validator) do
      SortFieldsParser.new(
        sort_params: sort_params,
        allowed: allowed
      )
    end

    context 'all sort params are all in allowed list' do
      let(:sort_params) do
        %w(foo blim)
      end

      it 'returns true' do
        expect(validator.valid?).to be(true)
      end
    end

    context 'some sort params are prefixed w/ a minus but are otherwise in the allowed list' do
      let(:sort_params) do
        %w(foo -blim)
      end

      it 'returns true' do
        expect(validator.valid?).to be(true)
      end
    end

    context 'some sort params are not in the allowed list' do
      let(:sort_params) do
        %w(foo bar baz)
      end

      it 'returns false' do
        expect(validator.valid?).to be(false)
      end
    end
  end

  describe '#parse_params!' do
    let(:validator) do
      SortFieldsParser.new(
        sort_params: sort_params,
        allowed: allowed
      )
    end

    context 'all sort params are in allowed list' do
      let(:sort_params) do
        %w(foo -blim)
      end

      it 'returns a Hash with sort params and their sort direction' do
        expect(validator.parse_params!).to eql({
          foo: :asc,
          blim: :desc,
        })
      end

      context 'some sort params are repeated' do
        let(:sort_params) do
          %w(foo bar -bar bar baz)
        end

        it 'raises an InvalidSortError' do
          expect { validator.parse_params! }.to raise_error(InvalidSortError)
        end
      end
    end

    context 'some sort params are not in the allowed list' do
      let(:sort_params) do
        %w(foo bar baz)
      end

      it 'raises an InvalidSortError' do
        expect { validator.parse_params! }.to raise_error(InvalidSortError)
      end
    end
  end
end
