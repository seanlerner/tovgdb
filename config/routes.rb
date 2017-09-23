Rails.application.routes.draw do
  # Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Resources
  resources :games, only: %i[index show new create]
  resources :creators, only: %i[index show]
  Game::MANY_TAGS.each do |tag|
    resources tag.symbol_pluralized, only: %i[index show]
  end
  %i[platforms series engines developers modes].each do |object|
    resources object, only: %i[index show]
  end

  # Search
  get 'simple_search', to: 'search#simple'
  get 'search', to: 'search#new'
  get 'search_results', to: 'search#results'

  # Pages
  get 'tags', to: 'page#tags'

  # Home
  get 'home', to: 'page#home'
  root 'page#home'
end
