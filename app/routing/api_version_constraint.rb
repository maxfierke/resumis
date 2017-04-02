class ApiVersionConstraint
  attr_reader :version

  def initialize(version:)
    @version = version
  end

  def matches?(request)
    version_header == version
  end

  private

  def version_header
    request.headers['X-Resumis-Version']
  end
end