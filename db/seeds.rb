require 'open-uri'
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts 'Destroying current database...'


url = 'http://tmdb.lewagon.com/movie/top_rated'
response = JSON.parse(URI.open(url).read)


puts 'Creating new movie database via API...'

response['results'].each do |movie_hash|
  puts
  p movie_hash
  base_poster_url = "https://image.tmdb.org/t/p/original"
  Movie.create!(
    title: movie_hash['title'],
    overview: movie_hash['overview'],
    poster_url: "#{base_poster_url}#{movie_hash['poster_path']}",
    rating: movie_hash['vote_average']
  )

  # create an instance with the hash
  # Movie.create!(
  #   poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path']
  #   ...
  # )
end

puts 'New database created!'
