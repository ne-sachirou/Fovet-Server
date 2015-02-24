json.array!(@thumbedup_movies) do |thumbedup_movie|
  json.extract! thumbedup_movie, :id, :movie_id, :user_id
  json.url thumbedup_movie_url(thumbedup_movie, format: :json)
end
