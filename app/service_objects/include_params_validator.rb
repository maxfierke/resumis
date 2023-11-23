class IncludeParamsValidator
  def initialize(include_params: [], allowed: [])
    @allowed = allowed
    @include_params = case include_params
    when String
      include_params.split(',')
    when Array
      include_params
    when NilClass
      []
    else
      raise InvalidIncludesError
    end
  end

  def self.include_params!(**kwargs)
    new(**kwargs).include_params!
  end

  def valid?
    @include_params.all? { |param| @allowed.include?(param) }
  end

  def include_params!
    raise InvalidIncludesError unless valid?
    @include_params
  end
end
