class JSONResumeConstraint
  def matches?(request)
    request.headers['Accept'] == 'application/vnd.resume+json'
  end
end
