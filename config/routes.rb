Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount_ember_app :frontend, to: "/ember"
  root to: 'plays#index'
  #root 'plays#bootstrap'
  # get '/*path' => 'ember#bootstrap'

  resources :plays do
  post 'auto_player' , on: :member
  get 'auto_player'
  end

end
