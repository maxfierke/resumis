class SortFieldsParser
  attr_reader :sort_params, :allowed

  def initialize(sort_params: [], allowed: [])
    @allowed = allowed
    @sort_params = case sort_params
    when String
      sort_params.split(',')
    when Array
      sort_params
    when NilClass
      []
    else
      raise InvalidSortError
    end
  end

  def self.parse_params!(**kwargs)
    new(**kwargs).parse_params!
  end

  def valid?
    sort_params.all? { |param| allowed.include?(param.delete_prefix("-")) }
  end

  def parse_params!
    raise InvalidSortError unless valid?

    sort_params.each_with_object({}) do |param, params|
      raise InvalidSortError if params.key?(param)

      if param.start_with?("-")
        key = param.delete_prefix("-")
        params[key.to_sym] = :desc
      else
        params[param.to_sym] = :asc
      end
    end
  end
end
