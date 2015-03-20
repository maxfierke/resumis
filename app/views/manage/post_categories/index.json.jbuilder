json.array!(@manage_post_categories) do |manage_post_category|
  json.extract! manage_post_category, :id
  json.url manage_post_category_url(manage_post_category, format: :json)
end
