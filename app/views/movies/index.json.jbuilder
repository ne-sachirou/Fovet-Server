json.array!(@movies) do |movie|
  json.extract! movie, :id, :count, :lat, :long, :uuid, :user_id
  json.url movie_url(movie, format: :json)
end
