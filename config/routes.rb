Basketball::Application.routes.draw do
  resources :teams

  match "/leagues/:league_id/teams/:team_id/news" => "news#index"

  root :to => 'high_voltage/pages#show', :id => 'app'
end
