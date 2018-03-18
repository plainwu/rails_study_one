Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :events do
  resources :attendees, :controller => 'event_attendees'
  resource :location, :controller => 'event_locations'
end


resources :events do
    collection do
        get :latest
    end
end

resources :events do
  collection do
  	    post :bulk_update
  end
end

resources :events do
    member do
        get :dashboard
    end
end

namespace :admin do
  resources :events
end

resources :events do
  member do
    post :join
    post :withdraw
  end
end

end