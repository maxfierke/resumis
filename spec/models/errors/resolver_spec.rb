require 'rails_helper'

RSpec.describe Errors::Resolver, type: :model do
  describe '#resolve_for' do
    context 'when a InvalidIncludesError' do
      it 'returns an Errors::InvalidSemantics' do
        error = Errors::Resolver.resolve_for(InvalidIncludesError.new)
        expect(error).to be_a(Errors::InvalidSemantics)
      end
    end

    context 'when a ActiveRecord::RecordNotFound' do
      it 'returns an Errors::NoRecordFound' do
        error = Errors::Resolver.resolve_for(ActiveRecord::RecordNotFound.new)
        expect(error).to be_a(Errors::NoRecordFound)
      end
    end

    context 'when a ActsAsTenant::Errors::NoTenantSet' do
      it 'returns an Errors::NoTenantSet' do
        error = Errors::Resolver.resolve_for(ActsAsTenant::Errors::NoTenantSet.new)
        expect(error).to be_a(Errors::NoTenantSet)
      end
    end

    context 'when a PayloadTypeMismatch' do
      it 'returns an Errors::PayloadTypeMismatch' do
        error = Errors::Resolver.resolve_for(PayloadTypeMismatch.new)
        expect(error).to be_a(Errors::PayloadTypeMismatch)
      end
    end

    context 'when a specific error for exception is not delcared' do
      it 'returns an Errors::GuruMeditation' do
        error = Errors::Resolver.resolve_for(StandardError.new)
        expect(error).to be_a(Errors::GuruMeditation)
      end
    end
  end
end
