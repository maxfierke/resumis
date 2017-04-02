class ApiVersionConstraint
  attr_reader :version

  def initialize(version:)
    @version = version
  end

  def matches?(request)
    request.headers['X-Resumis-Version'] == version
  end
end
