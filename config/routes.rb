Rails.application.routes.draw do
  get 'commodities/capture'

  get 'home' => 'pages#home'
  root 'pages#home'
end
