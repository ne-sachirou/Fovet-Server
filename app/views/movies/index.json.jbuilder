json.array!(@movies) do |movie|
  json.extract! movie, :count, :lat, :long, :uuid
  json.url movie_url(movie.uuid.to_param, format: :json)
end
