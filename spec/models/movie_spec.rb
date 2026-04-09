require 'rails_helper'

describe Movie do
  describe 'searching Tmdb by keyword' do
    it 'calls Faraday with the correct TMDb URL and parameters' do
      expect(Faraday).to receive(:get).with(
        'https://api.themoviedb.org/3/search/movie',
        hash_including(query: 'Inception')
      ).and_return(double('response', success?: false)) 

      Movie.find_in_tmdb('Inception')
    end
  end
end