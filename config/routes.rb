EmailAdventure::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      resources :stories do 
        collection do 
          post "start_story" => "stories#start_story", as: "start_story"
        end
      end
    end
  end

  resources :users do 
    resources :characters do 
      resources :email_accounts
    end
  end
  resources :stories do 
  	resources :scenes do 
  		resources :choices do 
  			post 'create_target_scene' => "choices#create_target_scene", as: "create_target_scene"
  		end
  	end
  end
end