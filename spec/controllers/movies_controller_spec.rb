require 'rails_helper'

describe MoviesController, type: :controller do
  describe 'searching TMDb' do
    it 'calls the model method that performs TMDb search' do
      expect(Movie).to receive(:find_in_tmdb).with('hardware')
      get :search_tmdb, params: { title: 'hardware' }
    end
   
    it 'selects the Search Results template for rendering' do
      allow(Movie).to receive(:find_in_tmdb)
      get :search_tmdb, params: { title: 'hardware' }
      expect(response).to render_template('search_tmdb')
    end

    describe 'adding a movie from TMDb' do
    it 'creates the movie and redirects to the search page' do
      fake_movie = double('Movie', title: 'Manhunter')
      expect(Movie).to receive(:create!).with(
        hash_including(title: 'Manhunter', release_date: '1986', rating: 'PG')
      ).and_return(fake_movie)
      post :add_tmdb, params: { title: 'Manhunter', release_date: '1986', rating: 'PG' }
      expect(flash[:notice]).to eq("Manhunter was successfully added to RottenPotatoes.")
      expect(response).to redirect_to('/search') 
    end
  end
    it 'makes the TMDb search results available to that template' do
      fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      get :search_tmdb, params: { title: 'hardware' }
      expect(assigns(:movies)).to eq(fake_results)
    end
  end
end