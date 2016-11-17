Rails.application.routes.draw do
  root 'pages#home'
  get '/ambassador', to: 'pages#ambassador'
  get '/buy', to: 'pages#buy'
  get '/impressum', to: 'pages#impressum'
  get '/solar_panel_art', to: 'pages#solar_panel_art'
end
