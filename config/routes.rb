EmailAdventure::Application.routes.draw do
  # for temporary use to get Mandrill working: (?)
  get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      resources :stories do 
        collection do 
          post "start_story" => "stories#start_story", as: "start_story"
          get "confirm_start" => "stories#confirm_start", as: "confirm_start"
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
    get "confirmation_success" => "stories#confirmation_success", as: "confirmation_success"
  	resources :scenes do 
  		resources :choices do 
  			post 'create_target_scene' => "choices#create_target_scene", as: "create_target_scene"
  		end
  	end
  end
end