module Errors
  class Resolver
    def self.resolve_for(exception)
      case exception
      when ::PayloadTypeMismatch
        PayloadTypeMismatch
      when InvalidIncludesError
        InvalidSemantics
      when ActiveRecord::RecordNotFound
        NoRecordFound
      when ActsAsTenant::Errors::NoTenantSet
        NoTenantSet
      when StandardError
        GuruMeditation
      end.new(exception)
    end
  end
end
