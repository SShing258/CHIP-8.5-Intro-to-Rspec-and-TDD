class Movie < ApplicationRecord
  def self.all_ratings
    %w[G PG PG-13 R]
  end

  def self.find_in_tmdb(string)
    api_key = ENV['TMDB_API_KEY']
  
    url = 'https://api.themoviedb.org/3/search/movie'
    response = Faraday.get(url, { api_key: api_key, query: string })
  
    return [] unless response.success?
    
    parsed_json = JSON.parse(response.body)
    parsed_json['results']
  end

  def self.with_ratings(ratings, sort_by)
    if ratings.nil?
      all.order sort_by
    else
      where(rating: ratings.map(&:upcase)).order sort_by
    end
  end
end
