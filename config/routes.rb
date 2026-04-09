Rottenpotatoes::Application.routes.draw do
  resources :movies
  get '/search', to: 'movies#search_tmdb', as: 'search_tmdb'
  post '/add_tmdb', to: 'movies#add_tmdb', as: 'add_tmdb'
  root to: redirect('/movies')
end
