class StubRequest
  def initialize(**kwargs)
    @struct = OpenStruct.new({
      uuid: 'uuid123',
      content_type: 'application/vnd.api+json',
      headers: {
        'X-Resumis-Version' => 'v1'
      }
    }.merge(kwargs))
  end

  def method_missing(symbol, *args)
    @struct.send(symbol, *args)
  end
end
