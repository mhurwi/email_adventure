EmailAdventure::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users do 
    resources :characters
  end
  resources :stories do 
  	resources :scenes do 
  		resources :choices do 
  			post 'create_target_scene' => "choices#create_target_scene", as: "create_target_scene"
  		end
  	end
  end
end