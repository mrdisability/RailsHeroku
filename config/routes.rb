Rails.application.routes.draw do
  root 'home#index'

  post 'zipcode' => 'home#zipcode'
end
