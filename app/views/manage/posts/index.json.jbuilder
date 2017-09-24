json.array!(@posts) do |post|
  json.extract! post, :id
  json.url edit_manage_post_url(post, format: :json)
end
