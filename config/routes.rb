Basketball::Application.routes.draw do
  resources :teams

  root :to => 'high_voltage/pages#show', :id => 'app'
end
