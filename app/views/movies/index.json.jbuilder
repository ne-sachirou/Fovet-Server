json.array!(@movies) do |movie|
  json.extract! movie, :count, :latitude, :longitude, :uuid, :created_at, :updated_at
  json.url movie_url(movie.uuid.to_param, format: :json)
end
